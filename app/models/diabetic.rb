class Diabetic < ActiveRecord::Base
  validates_presence_of :age, :name, :email
  validates_format_of :email, :with => /^\w+@\w+\.\w{2,5}$/
  validates_format_of :age, :with => /^\d+$/ # We validate the format and that it is not an integer at the same time
  has_many :records
end
