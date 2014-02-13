class RequestUser < ActiveRecord::Base
  belongs_to :request
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :request
end
