class SkillsController < ApplicationController
  def index
    @show_banner = true
    @skills = Skill.where("approved=? AND hidden=?",true,false).order("RANDOM()")
    respond_to do |format|
      format.html
      format.json {render json: @skills}
    end
  end

  def show
    @skill = Skill.find(params[:id])
    @lesson = nil
    if current_user
      @lesson = current_user.taken_class(@skill)
    end
    @review = Review.new
    @reviews = @skill.get_reviews()
    @completed_lessons = @skill.lessons.where(completed: true)
    max_index = [0, @completed_lessons.length - 4].max
    @completed_lessons_truncated = @completed_lessons[max_index..@completed_lessons.length]

    @confirm = params[:confirm]
    @return_to = request.path
    respond_to do |format|
      format.html
      format.json {render json: @skill}
    end
  end

  def create
    @skill = current_user.skills.new(skill_params)

    if @skill.save
      Notifier.skill_added(@skill).deliver
      redirect_to @skill, notice: 'Skill was successfully created.' 
    else
      render action: 'new'
    end

  end

  def new
    if not current_user
      redirect_to login_url(return_to: request.path)
      return
    end
    @skill = current_user.skills.new
  end

  def edit
    @skill = current_user.skills.find(params[:id])
  end

  def update
    @skill = current_user.skills.find(params[:id])
    if @skill.update(skill_params)
      redirect_to @skill, notice: 'Skill was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def skill_params
      params.require(:skill).permit(:title, :description, :qualifications, :picture)
    end
end
