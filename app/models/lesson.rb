class Lesson < ActiveRecord::Base
  belongs_to :skill
  belongs_to :user
  has_one :conversation
  has_many :reviews
  has_many :tokens


  def approve
    self.approved=true
    self.save!
  end

  def ignore
    self.ignored=true
    self.save!
  end

  def complete
    self.completed=true
    self.save!
  end

  def teacher
    if self.skill!=nil
      return self.skill.user
    else
      u=User.find_by(:first_name=>"Dhruv")
      return u
    end
  end

  def findOtherUser(user)
    other_user = nil
    if user == self.teacher
      other_user = self.user
    elsif user == self.user
      other_user = self.teacher
    end
    return other_user
  end

  def findToken(user)
    self.tokens.each do |token|
      if token.user == user
        return token
      end
    end
    return nil
  end

  def status(user)
    if user==self.teacher
      if !self.approved and !self.ignored
        return "Pending Request"
      elsif !self.approved and self.ignored
        return "Ignored Request"
      elsif self.approved and !self.completed
        return "Accepted Request"
      else
        return "Completed Lesson"
      end
    else
      if !self.approved and !self.ignored
        return "Inquiry"
      elsif !self.approved and self.ignored
        return "Not Accepted"
      elsif self.approved and !self.completed
        return "Accepted"
      else
        return "Completed Lesson"
      end
    end
  end
end

