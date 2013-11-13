class ConversationsController < ApplicationController
		
	def inbox
    @user=current_user
    @conversations=[]
    current_user.skills.each do |skill|
      skill.lessons.each do |lesson|
        @conversations.push(*lesson.conversation)
      end
    end
    current_user.lessons.each do |lesson|
      @conversations.push(*lesson.conversation)
    end
    @conversations=@conversations.sort_by{ |c| c.messages.last.created_at}.reverse!
  end

  def show
    @conversation = Conversation.find(params[:id])

    @message = Message.new
    receipt = @conversation.receipts.where(user_id: current_user.id).first
    if receipt
      receipt.update_attribute(read: true)
    end
  end

  def reply
    @conversation = Conversation.find(params[:message][:conversation_id])
    receiver_id=@conversation.lesson.teacher.id
    if current_user == @conversation.lesson.teacher
      receiver_id = @conversation.lesson.user.id
    end
    @message = @conversation.messages.create(body: params[:message][:body], sender: current_user.id, receiver: receiver_id)
    receipt = @conversation.receipts.where(user_id: current_user.id).first
    if receipt
      receipt.update_attribute(read: true)
    end
    redirect_to lesson_path(@conversation.lesson)
  end

end
