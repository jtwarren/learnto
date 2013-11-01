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

end
