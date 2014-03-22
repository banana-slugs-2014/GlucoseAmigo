require 'spec_helper'
describe Diabetic do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should allow_value("test@test.com").for :email}
  it { should_not allow_value("qlskr.com","teae",12).for :email}
  it { should allow_value(
    {
        year: Date.today.year - rand(15),
        month: Date.today.month,
        day: Date.today.day
    }
    ).for :birth_date }
  it { should belong_to :doctor }
  it { should belong_to :account }
end
