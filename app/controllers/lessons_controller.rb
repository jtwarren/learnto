class LessonsController < ApplicationController

def index
	if current_user != nil && current_user.admin
		@lessons = Lesson.all.order('updated_at DESC')
	else
		redirect_to root_path
	end
end

def show
	@lesson = Lesson.find(params[:id])
end

def approve
  @lesson = Lesson.find(params[:id])
  if current_user == @lesson.teacher
    @lesson.approve
  end
  redirect_to user_path(current_user)
end

def ignore
  @lesson = Lesson.find(params[:id])
  if current_user == @lesson.teacher
    @lesson.ignore
  end
  redirect_to user_path(current_user)
end

def complete
  @lesson = Lesson.find(params[:id])
  if current_user == @lesson.teacher
    @lesson.complete
  end
  redirect_to user_path(current_user)
end

end
