class Skill < ActiveRecord::Base
  default_scope where approved: true
  scope :pending, where(approved: false)

  belongs_to :user
  has_many :lessons
  has_many :reviews
end
