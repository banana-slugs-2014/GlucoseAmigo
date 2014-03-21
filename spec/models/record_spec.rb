require 'spec_helper'

describe Record do

  context "associations" do
    it {should belong_to :diabetic}
  end

  context "validations" do

    it { should_not allow_value('derp').for :weight }
    it { should_not allow_value('derp').for :glucose }

  end
end