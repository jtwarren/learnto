class Notifier < ActionMailer::Base
  default from: "founders@learnto.com"

  def skill_added(skill)
    @skill = skill
    emails = ['founders@learnto.com']
    if @skill.network
      if @skill.network.admin
        admin = User.find(@skill.network.admin)
        emails << admin.email
      end
    end
    mail(to: emails, subject: 'LearnTo: New skill added!' )
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
    emails = ['founders@learnto.com']
    if @event.network
      if @event.network.admin
        admin = User.find(@event.network.admin)
        emails << admin.email
      end
    end
    mail(to: emails, subject: 'LearnTo: New event added!' )
  end

  def request_added(request)
    @request = request
    emails = ['founders@learnto.com']
    if @request.network
      if @request.network.admin
        admin = User.find(@request.network.admin)
        emails << admin.email
      end
    end

    mail(to: emails, subject: 'LearnTo: New request added!' )
  end
  
  def event_attend(user, event)
    @user = user
    @event = event
    title = @event.title
    mail(to: @user.email, subject: 'LearnTo: Lesson confirmation: ' + @event.title)
  end

end