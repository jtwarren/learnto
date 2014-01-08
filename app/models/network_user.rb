class NetworkUser < ActiveRecord::Base
  belongs_to :network
  belongs_to :user

  # Validate unique user for each network
  validates_uniqueness_of :user_id, :scope => :network
end
