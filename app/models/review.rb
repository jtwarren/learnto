class Review < ActiveRecord::Base
belongs_to :skill
belongs_to :lesson
belongs_to :user
end
