class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  accepts_nested_attributes_for :skills
  # Associations
  has_many :accounts, :dependent => :destroy
  has_many :skills, :dependent => :destroy

  accepts_nested_attributes_for :skills

  attr_accessor :new_user

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

end