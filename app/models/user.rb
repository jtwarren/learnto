class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :skills
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_many :accounts, :dependent => :destroy

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

end