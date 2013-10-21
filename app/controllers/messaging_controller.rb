class MessagingController < ApplicationController
	def inbox
		@user=current_user
		@inbox = @user.mailbox.inbox
	end
end
