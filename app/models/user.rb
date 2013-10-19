class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :skills
  accepts_nested_attributes_for :skills

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # Associations
  has_many :accounts, :dependent => :destroy

  attr_accessor :new_user

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end


end