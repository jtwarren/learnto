class RegularUser < User

  has_secure_password

  attr_accessor :new_user

  validates :first_name, :last_name, :email, :picture, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def name
  	return first_name+last_name
  end
end