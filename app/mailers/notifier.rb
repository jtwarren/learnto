class Notifier < ActionMailer::Base
  default from: "founders@learnto.com"

  def skill_added(skill)
    @skill = skill
    mail(to: 'founders@learnto.com', subject: 'LearnTo: New skill added!' )
  end

  def lesson_request(user, requestor, lesson)
    @user = user
    user_email = "#{@user.name} <#{@user.email}>"
    @requestor = requestor
    requestor_email = "#{@requestor.name} <#{@requestor.email}>"
    @lesson = lesson
    mail(to: user_email, subject: 'LearnTo: New lesson request from ' + requestor.first_name + '!')
  end

  def reply(message)
    @message = message
    @sender = message.user
    @receiver = message.conversation.lesson.skill.user
    receiver_email = "#{@receiver.name} <#{@receiver.email}>"
    mail(to: receiver_email, subject: 'LearnTo: New message from ' + @sender.first_name)
  end

  def event_added(event)
  end

end