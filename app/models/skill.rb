class Skill < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :qualifications, presence: true
  validates :picture, presence: true

  belongs_to :user
  has_many :lessons


  def get_reviews()
    reviews=[]
    self.lessons.each do |lesson|
      reviews.push(*lesson.reviews)
    end
    return reviews
  end

  def hide
    self.hidden=true
    self.save!
  end

  def similar_skills
    return Skill.order("RANDOM()").first(5)
  end

end

