class SkillsController < ApplicationController
  def index
    @show_banner = true
    @skills = Skill.where("approved = ? AND hidden = ? AND public = ?", true, false, true).order("RANDOM()")
    @events = Event.where("approved = ? AND public = ?", true, true).where("starts_at >= ?", DateTime.now).order("RANDOM()")

    @user = current_user

    if session[:new_user]
      @show_user_bio = true
      session.delete(:new_user)
    end

    respond_to do |format|
      format.html
      format.json {render json: custom_json_for(@skills)}
    end
  end

  def show
    @skill = Skill.find(params[:id])
    # @lesson = nil
    # if current_user
    #   @lesson = current_user.taken_class(@skill)
    #   if @lesson
    #     @review = current_user.reviewFor(@skill.user, @lesson)
    #   end
    # end
    # if !@review
    #   @review = Review.new
    # end

    if current_user and session[:show_modal] and session[:skill_id] == @skill.id
      @show_modal = true
      session.delete(:show_modal)
      session.delete(:skill_id)
    end

    if not current_user
      session[:show_modal] = true
      session[:skill_id] = @skill.id
    end

    if current_user
      @show_review_form = current_user.lessons.where(status:"COMPLETED").map(&:skill).include?(@skill) && !@skill.reviews.map(&:user).include?(current_user)
      if @show_review_form
        @review = Review.new
        @lesson = current_user.lessons.where(skill_id: @skill.id).first
      end
    end


    @reviews = @skill.reviews

    @completed_lessons = @skill.lessons.where(status: "COMPLETED").last(4)

    @return_to = request.path

    respond_to do |format|
      format.html
      format.json {render json: custom_json_for_single_skill(@skill)}
    end
  end

  def create
    @skill = current_user.skills.new(skill_params)

    if @skill.save
      Notifier.skill_added(@skill).deliver
      redirect_to @skill
    else
      render 'new'
    end
  end

  def new
    if not current_user
      redirect_to login_url(return_to: request.path)
      return
    end
    @skill = Skill.new
  end

  def edit
    @skill = current_user.skills.find(params[:id])
  end

  def remove
    @skill = current_user.skills.find(params[:id])
    @skill.hidden = true
    @skill.save!
    flash[:warning] = "Skill removed"
    redirect_to root_url
  end


  def update
    @skill = current_user.skills.find(params[:id])
    if @skill.update(skill_params)
      redirect_to @skill, notice: 'Skill was successfully updated.'
    else
      render 'edit'
    end
  end

  private
    def custom_json_for_single_skill(skill)
      value = 
      {
        teacher: skill.user.name,
        picture: skill.picture,
        description: skill.description,
        qualifications: skill.qualifications,
        reviews: skill.reviews,
        title: skill.title    
      }
      return value.to_json
    end

    def skill_params
      params.require(:skill).permit(:title, :description, :qualifications, :picture, :public)
    end

    def custom_json_for(value)
      list = value.map do |skill|
        {
          teacher: skill.user.name,
          picture: skill.picture,
          description: skill.description,
          qualifications: skill.qualifications,
          reviews: skill.reviews,
          title: skill.title
        }
      end
      return list.to_json
    end
end
