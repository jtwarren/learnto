class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
<<<<<<< HEAD
  has_many :skills
  accepts_nested_attributes_for :skills

  validates :email, presence: true, uniqueness: { case_sensitive: false }
=======
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
>>>>>>> f912cc3be439e9a235add3f97220b60d35d08170
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