require 'spec_helper'

describe Comment do
  it { should validate_presence_of :name }
  it { should have_many :diabetics }
end