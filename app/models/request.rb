class Request < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :picture, presence: true

  belongs_to :user
  has_many :lessons

  has_many :networks, :through => :user


  def hide
    self.hidden = true
    self.save!
  end

  def similar_requests
    if self.networks.size == 0
      return Request.where("approved = ? AND hidden = ? AND public = ?", true, false, true).order("RANDOM()").first(3)
    else
      return self.networks.first.requests.where("approved = ? AND hidden = ?", true, false).order("RANDOM()").first(3)
    end
  end

end
