class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  acts_as_messageable
  # Associations
  has_many :accounts, :dependent => :destroy
  has_many :skills, :dependent => :destroy
  has_and_belongs_to_many :lessons
  has_many :reviews
  has_many :receipts
  has_many :lessons

  has_many :network_users
  has_many :networks, :through => :network_users

  accepts_nested_attributes_for :skills,  :reject_if => lambda { |c| c[:title].blank? }

  attr_accessor :new_user

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end


  def name
    return first_name + " " + last_name
  end

  def taken_class(skill)
    lesson = self.lessons.where(skill_id: skill.id).first
    return lesson
  end

  def taken_lesson(lesson)
    return self.lessons.include? lesson
  end

  def taught_lesson(lesson)
    return self.lessons_taught.include? lesson
  end

  def lessons_taught
    lessons = []
    self.skills.each do |skill|
      skill.lessons.each do |lesson|
        lessons.push(*lesson)
      end
    end
    return lessons
  end

  def teaching_reviews
    reviews = []
    self.skills.each do |skill|
      skill.lessons.each do |lesson|
        lesson.reviews.each do |review|
          if review.target_user_id == self.id
            reviews.push(*review)
          end
        end
      end
    end
    return reviews
  end

  def learning_reviews
    reviews = []
    self.lessons.each do |lesson|
      lesson.reviews.each do |review|
        if review.target_user_id == self.id
          reviews.push(*review)
        end
      end
    end
    return reviews
  end    

  def tookLessonWith (user)
    self.lessons.each do |lesson|
      if lesson.teacher == user
        return true
      end
    end
    self.skills.each do |skill|
      skill.lessons.each do |lesson|
        if lesson.user == user
          return true
        end
      end
    end
    return false
  end

  def reviewFor(user, lesson)
    lesson.reviews.each do |review|
      if review.target_user_id == user.id
        return review
      end
    end
    return nil
  end

  def unread
    unread = self.receipts.where(read: false)
    return unread.size
  end


end