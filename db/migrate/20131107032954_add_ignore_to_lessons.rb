class AddIgnoreToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :ignored, :boolean, :default=>false
  end
end
