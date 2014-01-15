class CreateLessonUsers < ActiveRecord::Migration
  def change
    create_table :lesson_users do |t|
      t.references :lesson, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
