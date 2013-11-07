class Lesson < ActiveRecord::Base
  belongs_to :skill
  has_and_belongs_to_many :users
  has_one :review


  def approve
    self.approved=true
    self.save!
  end

  def ignore
    self.ignored=true
    self.save!
  end

  def complete
    self.completed=true
    self.save!
  end

end
