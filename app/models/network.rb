class Network < ActiveRecord::Base
  has_many :network_users
  has_many :users, :through => :network_users
  has_many :skills, :through => :users
  has_many :events, :through => :users
  has_many :requests, :through => :users
end
