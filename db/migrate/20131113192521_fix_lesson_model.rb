class FixLessonModel < ActiveRecord::Migration
  def change
    remove_column :lessons, :name
    remove_column :lessons, :email

    drop_table :lessons_users
  end
end
