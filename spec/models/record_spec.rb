require 'spec_helper'

describe Record do

  context "associations" do
    it {should belong_to :diabetic}
  end


  context "validations" do
    xit {should validate_presence_of :body }
  end
end