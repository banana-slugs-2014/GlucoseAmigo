class Diabetic < ActiveRecord::Base
  attr_accessible :name, :email, :birth_date
  belongs_to :account
  belongs_to :doctor
  validates_presence_of :name, :email, :age
  validates_format_of :email, :with => /^\w+@\w+\.\w{2,5}$/
  validates_format_of :age, :with => /^\d+$/ # We validate the format and that it is not an integer at the same time
  has_many :records

  def birth_date=(date)
    bd = Date.parse(date.values.join('-'))
    age = Date.today.year - bd.year
    age -= 1 if Date.today < bd + age.years
    self.age = age.to_s
  end
end
