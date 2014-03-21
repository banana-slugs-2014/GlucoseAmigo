class Preference < ActiveRecord::Base

  belongs_to :user
  validates_numericality_of :frequency, :allow_nil => true, :greater_than_or_equal_to => 0

end