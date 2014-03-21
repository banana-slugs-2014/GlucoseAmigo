class Diabetic < ActiveRecord::Base
  validates_presence_of :age, :name, :email
  # Validation for Phone sets confirmed
  validates_format_of :email, :with => /^\w+@\w+\.\w{2,5}/
end
