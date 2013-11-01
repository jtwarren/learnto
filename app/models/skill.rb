class Skill < ActiveRecord::Base
  belongs_to :user
  has_many :lessons
  has_many :reviews
end
