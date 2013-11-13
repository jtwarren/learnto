class Notifier < ActionMailer::Base
  default from: "founders@learnto.com"

  def skill_added(skill)
    @skill = skill
    mail(to: 'jeff@learnto.com', subject: 'LearnTo: New skill added!' )
  end

  def lesson_request(user, requestor, lesson)
    @user = user
    user_email = "#{@user.name} <#{@user.email}>"
    @requestor = requestor
    requestor_email = "#{@requestor.name} <#{@requestor.email}>"
    @lesson = lesson
    mail(to: user_email, subject: 'LearnTo: New lesson request from #{requestor.first_name}!' )
  end
  
end