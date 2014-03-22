class Diabetic < ActiveRecord::Base
  attr_accessible :name, :email, :birthday
  validates_presence_of :name, :email, :birthday
  validates_format_of :email, :with => /^\w+[\.\w\-]*@\w+\.\w{2,5}$/
  validates_format_of :birthday, :with => /^\d{4}-\d{1,2}-\d{1,2}$/ # We validate the format and that it is not an integer at the same time
  belongs_to :account
  belongs_to :doctor
  has_many :records

  before_save :convert_birthday

  def convert_birthday
    self.birthday = Date.parse(self.birthday.values.join('-'))
  end

  def age
    age = Date.today.year - self.birthday.year
    age -= 1 if Date.today < self.birthday.year + age.years
  end
end
