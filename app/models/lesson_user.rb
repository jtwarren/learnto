class LessonUser < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user

  # Validate unique user for each lesson
  validates_uniqueness_of :user_id, :scope => :lesson
end
