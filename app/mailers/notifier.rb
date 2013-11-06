class Notifier < ActionMailer::Base
  default from: "founders@learnto.com"

  def skill_added(skill)
    @skill = skill
    mail(to: 'jeff@learnto.com', subject: 'LearnTo: New skill added!' )
  end

  def lesson_request(user, requestor, skill)
    @user = user
    user_email = "#{@user.name} <#{@user.email}>"
    @requestor = requestor
    requestor_email = "#{@requestor.name} <#{@requestor.email}>"
    @skill = skill
    mail(to: user_email, cc: requestor_email, subject: 'LearnTo: New lesson request!' )
  end
end
