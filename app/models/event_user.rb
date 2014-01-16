class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  # Validate unique user for each event
  validates_uniqueness_of :user_id, :scope => :event
end
