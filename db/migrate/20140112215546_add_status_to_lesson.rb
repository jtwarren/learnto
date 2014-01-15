class AddStatusToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :status, :string
    Lesson.all.each do |lesson|
      if lesson.completed
        lesson.update(status:"COMPLETED")
      elsif lesson.approved
        lesson.update(status:"APPROVED")
      elsif lesson.ignored
        lesson.update(status:"IGNORED")
      else
        lesson.update(status:"PENDING")
      end
    end
  end
end