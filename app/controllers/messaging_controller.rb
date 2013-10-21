class MessagingController < ApplicationController
	def inbox
		@user=current_user
		@inbox = @user.mailbox.inbox
		@reply = Notification.new
	end

	def reply
		@user=current_user
		conversation = Conversation.find(params[:conversation_id])
		reply_message = params[:replytext]
		@user.reply_to_conversation(conversation, reply_message)
		redirect_to inbox_path
	end
end
