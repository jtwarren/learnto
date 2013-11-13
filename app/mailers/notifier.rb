class Notifier < ActionMailer::Base
  default from: "founders@learnto.com"

  def skill_added(skill)
    @skill = skill
    mail(to: 'jeff@learnto.com', subject: 'LearnTo: New skill added!' )
  end

  def lesson_request(requestor, lesson)
    receiver = lesson.skill.user
    body = "Hey #{receiver.first_name}, \n \n #{requestor.first_name} has requested to learn #{skill.title} from you! To respond to this message and find out more about #{requestor.first_name}, go to #{lesson_url(lesson)} to respond to this request!"
    mail(to: receiver.email, bcc: "founders@learnto.com", subject: 'LearnTo: New lesson request from #{requestor.first_name}!' )
  end

  def new_message(message)
    receiver_email = User.find(message.receiver).email
    body = "Go to " +conversation_url(message.conversation.lesson) + " to read the message and respond!"
    mail(to: receiver_email, bcc: "founders@learnto.com", subject: 'LearnTo: New Message From' + User.find(message.sender).first_name, body: body)
  end
end

