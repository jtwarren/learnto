class SkillsController < ApplicationController
  def index
    @skills = Skill.where(approved: true).order("RANDOM()")
    respond_to do |format|
      format.html
      format.json {render json: @skills}
    end
  end

  def show
    @skill = Skill.find(params[:id])
    @path = nil
    @confirm = params[:confirm]
    if current_user != nil
      @path = user_inquire_post_url
    else
      @path = '/auth/facebook'
    end
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
      session[:return_to] = request.fullpath
      redirect_to login_url
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
