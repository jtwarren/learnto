class AddCompletedToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :completed, :boolean, :default=>false
  end
end
