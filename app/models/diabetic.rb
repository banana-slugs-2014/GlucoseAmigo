class Diabetic < ActiveRecord::Base
  attr_accessible :name, :email, :birthday
  validates_presence_of :name, :email, :birthday
  validates_format_of :email, :with => /^\w+[\.\w\-]*@\w+\.\w{2,5}$/
  belongs_to :account
  belongs_to :doctor
  has_many :records
  has_one :preference

  before_save :convert_birthday

  def convert_birthday
    self.birthday = Date.parse(self.birthday.values.join('-'))
  end

  def age
    age = Date.today.year - self.birthday.year
    age -= 1 if Date.today < self.birthday.year + age.years
  end
end
