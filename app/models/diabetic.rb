class Diabetic < ActiveRecord::Base
  validates_presence_of :age, :name, :email
  validates_format_of :email, :with => /^\w+@\w+\.\w{2,5}$/
  validates_format_of :age, :with => /^\d+$/
end
