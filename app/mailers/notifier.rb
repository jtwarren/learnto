class Notifier < ActionMailer::Base
  default from: "founders@learnto.com"

  def skill_added(skill)
    @skill = skill
    emails = ['founders@learnto.com']
    if @skill.networks.first
      if @skill.networks.first.admin
        admin = User.find(@skill.networks.first.admin)
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

  def lesson_offer(receivers, teacher, lesson)
    @teacher = teacher
    emails = []
    receivers.each do |receiver|
      emails << receiver.email
    end
    @lesson = lesson
    mail(to: emails, subject: 'LearnTo: #{@teacher.first_name} has offered to help you learn!')
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
    if @event.networks.first
      if @event.networks.first.admin
        admin = User.find(@event.networks.first.admin)
        emails << admin.email
      end
    end
    mail(to: emails, subject: 'LearnTo: New event added!' )
  end

  def request_added(request)
    @request = request
    emails = ['founders@learnto.com']
    if @request.networks.first
      if @request.networks.first.admin
        admin = User.find(@request.networks.first.admin)
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