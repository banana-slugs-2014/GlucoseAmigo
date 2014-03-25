class Record < ActiveRecord::Base
  DATA_RANGE_FACTOR = 600 # 10 minutes

  attr_accessible :weight, :glucose, :taken_at, :comment
  belongs_to :diabetic

  validate :inclusion_of_weight_and_or_glucose
  validate :taken_date_cannot_be_in_the_future
  validates_presence_of :taken_at
  validates_numericality_of :glucose, :weight



  def inclusion_of_weight_and_or_glucose
    unless self.weight.present? || self.glucose.present?
      errors.add(:weight, "Must include either weight or glucose")
      errors.add(:glucose, "Must include either weight or glucose")
    end
  end

  def taken_date_cannot_be_in_the_future
    if in_the_future?
      errors.add(:taken_at, "Time data was taken must be before now")
    end
  end

  def in_the_future?
    taken_at.present? && taken_at > (Time.now + DATA_RANGE_FACTOR)
  end

end
