class Token < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  def acceptCredit(user)
    user.credits -= 1
    user.save!
    self.paid = true
    self.save!
  end
end
