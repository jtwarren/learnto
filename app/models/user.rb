class User < ActiveRecord::Base

  # Associations
  has_many :accounts, :dependent => :destroy

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

end