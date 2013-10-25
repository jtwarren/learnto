class CreateLessonsUsersTable < ActiveRecord::Migration
  def change
    create_table :lessons_users do |t|
    	t.belongs_to :lesson
    	t.belongs_to :user
    end
  end
end
