class Event < ActiveRecord::Base
  belongs_to :user

  has_many :event_users
  has_many :students, :through => :event_users, :source => :user

  geocoded_by :address
  after_validation :geocode
end
