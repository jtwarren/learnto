class SkillsController < ApplicationController
  def index
    @show_banner = true
    @skills = Skill.where("approved = ? AND hidden = ?", true, false).order("RANDOM()")
    @events = Event.where("approved = ?", true).order("RANDOM()")
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

  def networks
    if not current_user
      redirect_to skills_url, notice: "Please log in to view lessons within your networks."
    end
    @show_banner = true
    @hide_about_me = true
    @skills = current_user.networks.map(&:skills).flatten.uniq
    @events = []
    render 'index'
  end

  def show
    @skill = Skill.find(params[:id])
    @lesson = nil
    if current_user
      @lesson = current_user.taken_class(@skill)
      if @lesson
        @review = current_user.reviewFor(@skill.user, @lesson)
      end
    end
    if !@review
      @review = Review.new
    end

    @reviews = @skill.get_reviews()

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
        reviews: skill.get_reviews,
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
          reviews: skill.get_reviews,
          title: skill.title
        }
      end
      return list.to_json
    end
end
