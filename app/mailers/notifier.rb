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

  def reply(message, sender, receiver)
    @message = message
    @sender = sender
    @receiver = receiver

    receiver_email = "#{receiver.name} <#{receiver.email}>"
    mail(to: receiver_email, subject: 'LearnTo: New message from ' + sender.first_name)
  end

  def event_added(event)
    @event = event
    mail(to: 'founders@learnto.com', subject: 'LearnTo: New event added!' )
  end

  def request_added(request)
    @request = request
    mail(to: 'founders@learnto.com', subject: 'LearnTo: New request added!' )

  def event_attend(user, event)
    @user = user
    @event = event
    title = @event.title
    mail(to: @user.email, subject: 'LearnTo: Lesson confirmation: ' + @event.title)
  end

end