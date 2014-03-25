require 'spec_helper'
describe "Doctor's Page", :js => true do
  before(:each) do
    visit root_path
    click_on "Sign up !"
    fill_in "Username", with: 'Po'
    fill_in "Email", with: 'business@business.com'
    fill_in "Password", with: 'business'
    fill_in "Password Confirmation", with: 'business'
    click_on "Sign up"
    fill_in 'diabetic_name', :with => 'John Doe'
    select("2013",:from=> "diabetic_birthday_1i")
    select("March",:from=> "diabetic_birthday_2i")
    select("24",:from=> "diabetic_birthday_3i")
    fill_in 'diabetic_email', :with => 'doe@doe.com'
    click_on "Create"
  end
  context "Create Doctor" do
    it "brings you to preferences page after clicking create" do
      fill_in "Name", :with => "Dr. Chewy"
      fill_in "Fax", :with => "510-998-6754"
      fill_in "Email", :with => "chewy@chews.com"
      fill_in "Comments", :with => "This better work!"
      click_on "Save Doctor"
      expect(page).to have_content "Reminders"
    end

    it "brings you back to dashboard after clicking on cancel" do
      click_on "Cancel"
      expect(page).to have_content "Po's Dashboard"
    end
  end
end
