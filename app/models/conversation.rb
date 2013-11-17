class Conversation < ActiveRecord::Base
  has_many :messages
  has_many :receipts
  belongs_to :lesson

  def updateTime
    return self.messages.last.updated_at
  end

  def read(user)
    receipt = self.receipts.where(user_id: user.id).first
    if receipt
      return receipt.read
    end
    return false
  end  

  def inquiry(user)
    if self.lesson.teacher!=user
      return true
    end
    return false
  end
end
