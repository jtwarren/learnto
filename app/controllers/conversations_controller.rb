class ConversationsController < ApplicationController
		
	def inbox
    @user = current_user
    @conversations = []
    if current_user
      current_user.skills.each do |skill|
        skill.lessons.each do |lesson|
          @conversations.push(*lesson.conversation)
        end
      end
      current_user.lessons.each do |lesson|
        @conversations.push(*lesson.conversation)
      end
      @conversations = @conversations.sort_by{ |c| c.messages.last.created_at}.reverse!
    else
      redirect_to login_url(return_to: inbox_conversations_path)
    end
  end

  def show
    @conversation = Conversation.find(params[:id])

    @message = Message.new
    receipt = @conversation.receipts.where(user_id: current_user.id).first
    if receipt
      receipt.update(read: true)
    end
  end

  def reply
    @conversation = Conversation.find(params[:message][:conversation_id])
    @message = @conversation.messages.create(body: params[:message][:body], user: current_user)

    receipt = @conversation.receipts.where(user_id: current_user.id).first
    
    if receipt
      receipt.update(read: true)
    end

    Notifier.reply(@message).deliver

    redirect_to lesson_path(@conversation.lesson)
  end

end
