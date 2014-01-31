class Request < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :picture, presence: true

  belongs_to :user
  has_many :lessons

  has_many :networks, :through => :user
end
