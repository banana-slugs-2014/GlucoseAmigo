require 'spec_helper'
describe Diabetic do
  it { should validate_presence_of :name }
  it { should validate_presence_of :age }
  it { should validate_presence_of :email }
  it { should allow_value("test@test.com").for :email}
  it { should_not allow_value("qlskr.com","teae",12).for :email}
  it { should allow_value("12").for :age }
  it { should_not allow_value(12,"test").for :age }
end
