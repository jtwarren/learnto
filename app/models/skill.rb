
class Skill < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :qualifications, presence: true
  validates :picture, presence: true

  belongs_to :user
  has_many :lessons

  has_many :reviews, :through => :lessons


  def hide
    self.hidden = true
    self.save!
  end

  def similar_skills
    return Skill.where("approved = ? AND hidden = ? AND public = ?", true, false, true).order("RANDOM()").first(3)
  end

end

