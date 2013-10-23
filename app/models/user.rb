class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_many :accounts, :dependent => :destroy
  has_many :skills, :dependent => :destroy

  accepts_nested_attributes_for :skills

  attr_accessor :new_user

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end


  def name
    return first_name+" "+last_name
  end

  def mailboxer_email(object)
    return email
  end

end