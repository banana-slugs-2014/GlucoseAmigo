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
  has_one :preference

  after_initialize :convert_birthday

  def age
    age = Date.today.year - self.birthday.year
    age -= 1 if Date.today < self.birthday.year + age.years
  end



  def get_data_for_graph(number_of_days=7)
    collection = self.records.where(taken_at: (Time.now.midnight - number_of_days.days)..Time.now.midnight)
    get_data(collection)
  end


  private

  def get_data(collection)
    #could take an argument for a range of data
     glucose_graph_data = {}
     weight_graph_data = {}
     collection.each do |record|
       glucose_graph_data[record.taken_at.localtime.strftime('%a %m/%d').to_s] = record.glucose.to_i if record.glucose.to_i
       weight_graph_data[record.taken_at.localtime.strftime('%a %m/%d').to_s] = record.weight.to_i if record.weight.to_i
     end
     [glucose_graph_data, weight_graph_data]
  end

  def birthday_cant_be_in_the_future
    if birthday.present? && birthday >= Date.today
      errors.add(:birthday, "must be before today")
    end
  end

  def convert_birthday
    if self.birthday.is_a? Hash
      self.birthday = Date.parse(self.birthday.values.join('-'))
    end
  end



end
