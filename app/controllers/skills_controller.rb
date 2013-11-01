class SkillsController < ApplicationController
  def index
    @skills = Skill.all.order("RANDOM()")
  end

  def show
    @skill = Skill.find(params[:id])
    @path = nil
    if current_user != nil
      @path = user_inquire_post_url
    else
      @path = '/auth/facebook'
    end
  end

  def send_request
  	request = params[:request]
  	skill = Skill.find(params[:skill_id])
  	@user = current_user
  	@user.send_message(skill.user, request ,"Request to learn to" + skill.title)
    redirect_to skills_path
  end
end
