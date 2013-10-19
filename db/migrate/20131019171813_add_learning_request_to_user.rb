class AddLearningRequestToUser < ActiveRecord::Migration
  def change
  	add_column :users, :learning_request, :text
  end
end
