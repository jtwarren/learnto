class Lesson < ActiveRecord::Base
  belongs_to :skill
  has_and_belongs_to_many :users
end
