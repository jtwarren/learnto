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
    @conversations.sort_by{ |c| c.updateTime}
    @conversations=@conversations.reverse!
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  def reply
    @conversation = Conversation.find(params[:message][:conversation_id])
    receiver_id=@conversation.lesson.teacher
    if current_user == @conversation.lesson.teacher
      receiver_id = @conversation.lesson.user
    end
    @message = @conversation.messages.create(body: params[:message][:body], sender: current_user.id, receiver: receiver_id)
    redirect_to conversation_path(@conversation.id)
  end

end
