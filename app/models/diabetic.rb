class Diabetic < ActiveRecord::Base
  attr_accessible :name, :email, :birthday

  # Validations
  validates_presence_of :name, :email, :birthday
  validates_format_of :email, :with => /^\w+[\.\w\-]*@\w+\.\w{2,5}$/
  validate :birthday_cant_be_in_the_future

  # Associations
  belongs_to :account
  belongs_to :doctor
  has_many :records

  after_initialize :convert_birthday

  def age
    age = Date.today.year - self.birthday.year
    age -= 1 if Date.today < self.birthday.year + age.years
  end

  private

  def birthday_cant_be_in_the_future
    if birthday.present? && birthday >= Date.today
      errors.add(:birthday, "must be before today")
    end
  end

  def convert_birthday
    if self.birthday.is_a? Hash
      self.birthday = Date.parse( self.birthday.values.join('-') )
    end
  end
end
