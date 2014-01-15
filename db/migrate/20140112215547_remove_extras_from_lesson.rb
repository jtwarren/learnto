class RemoveExtrasFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, "{:index=>true}_id"
    remove_column :lessons, :learning_request
    remove_column :lessons, :approved
    remove_column :lessons, :ignored
    remove_column :lessons, :completed
  end
end
