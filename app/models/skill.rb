
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
    return Skill.where("approved=? AND hidden=?", true, false).order("RANDOM()").first(3)
  end





  private

    def euclidean_distance(vector1, vector2)
      sum = 0
      vector1.zip(vector2).each do |v1, v2|
        component = (v1 - v2)**2 
        sum += component 
      end 
      Math.sqrt(sum) 
    end

    def average(vectors)
      vectors[0].zip(*vectors.slice(1, vectors.length)).map {|array| array.reduce(:+) / array.size }
    end




end

