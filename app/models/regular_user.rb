class RegularUser < User

  has_secure_password

  attr_accessor :new_user

  validates :first_name, :last_name, :email, presence: true
  validates :email, email: true
  validates :email, uniqueness: { case_sensitive: false }

end