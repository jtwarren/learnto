
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
    skills = Skill.where("approved=? AND hidden=?", true, false)

    @words = skills.map do |skill| 
      skill.description.split(' ')
    end.flatten.uniq

    @vectors = skills.map do |skill|
      @words.map do |w| 
        skill.description.include?(w) ? 1 : 0 
      end
    end

    number_centers = Skill.count / 5

    @cluster_centers = @vectors.slice(0, number_centers)

    15.times do
      @clusters = Array.new(number_centers){[]}
     
      @vectors.each do |vector|
        min_distance, min_point = 99999, 0
     
        @cluster_centers.each.with_index do |center, i|
          if euclidean_distance(center, vector) < min_distance
            min_distance = euclidean_distance(center, vector)
            min_point = i
          end
        end
     
        @clusters[min_point] << vector
      end
     
      @cluster_centers = @clusters.map do |vectors|
        average(vectors)
      end
    end

    c = nil
    @clusters.each do |cluster|
      cluster.each do |vector|
        if self == skills[@vectors.index(vector)]
          c = cluster
        end
      end
    end



    if c != nil
      ret = []
      c.each do |vector|
        if self != skills[@vectors.index(vector)]
          ret << skills[@vectors.index(vector)]
        end
      end
      return ret.first(3)
    end

    return Skill.order("RANDOM()").first(3)

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

