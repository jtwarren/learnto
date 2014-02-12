
class Skill < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :qualifications, presence: true
  validates :picture, presence: true

  belongs_to :user
  has_many :lessons

  has_many :networks, :through => :user
  has_many :reviews, :through => :lessons


  def hide
    self.hidden = true
    self.save!
  end

  def similar_skills
    if self.networks.size == 0
      return Skill.where("approved = ? AND hidden = ? AND public = ?", true, false, true).order("RANDOM()").first(3)
    else
      return self.networks.first.skills.where("approved = ? AND hidden = ?", true, false).order("RANDOM()").first(3)
    end
  end

  def openLessons
    lessons = []
    self.lessons.each do |lesson|
      if lesson.status == "APPROVED"
        lessons << lesson
      end
    end
    return lessons
  end

end

