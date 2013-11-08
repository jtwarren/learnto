class Conversation < ActiveRecord::Base
  has_many :messages
  belongs_to :lesson

  def updateTime
    return self.messages.last.updated_at
  end

end
