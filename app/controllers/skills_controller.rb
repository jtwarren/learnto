class SkillsController < ApplicationController
  def index
    @skills = Skill.all.order("RANDOM()")
    @disable_nav = true
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def send_request
  	request = params[:request]
  	skill = Skill.find(params[:skill_id])
  	@user = current_user
  	@user.send_message(skill.user, request ,"Request to learn to" + skill.title)
    redirect_to skills_path
  end
end
