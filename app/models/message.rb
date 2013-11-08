class Message < ActiveRecord::Base
  belongs_to :conversation

  def findSender
    return User.find(self.sender)
  end

  def findReceiver
    return User.find(self.receiver)
  end
end
