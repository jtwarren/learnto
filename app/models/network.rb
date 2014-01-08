class Network < ActiveRecord::Base
  has_many :network_users
  has_many :users, :through => :network_users
  has_many :skills, :through => :users
end
