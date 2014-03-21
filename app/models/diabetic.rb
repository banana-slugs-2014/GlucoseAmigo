class Diabetic < ActiveRecord::Base
  validates_presence_of :age, :name, :email
  # Validation for Phone sets confirmed
end
