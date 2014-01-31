class Lesson < ActiveRecord::Base
  belongs_to :skill
  belongs_to :request
  belongs_to :user
  has_one :conversation
  has_many :reviews

  has_many :lesson_users
  has_many :users, :through => :lesson_users

  # This should work but prevents creation of lessons.
  # validates_inclusion_of :status, :in => %w(PENDING, APPROVED, COMPLETED, IGNORED)

  def approve
    self.update(status: "APPROVED")
  end

  def ignore
    self.update(status: "IGNORED")
  end

  def complete
    self.update(status: "COMPLETED")
  end

  def teacher
    if self.skill != nil and self.skill.user
      self.skill.user
    else
      User.find_by(:first_name => "Dhruv")
    end
  end
end

