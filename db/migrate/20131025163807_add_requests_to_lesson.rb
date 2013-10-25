class AddRequestsToLesson < ActiveRecord::Migration
  def change
  	add_column :lessons, :learning_request, :text
  end
end
