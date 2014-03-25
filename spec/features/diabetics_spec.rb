require 'spec_helper'
describe "Diabetic Page", :js => true do

  context "add a diabetic" do
    it " brings you to add doctor after clicking create" do
      visit root_path
      click_on "Sign up !"
      fill_in "Username", with: 'Bob'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'testing'
      fill_in "Password Confirmation", with: 'testing'
      click_on "Sign up"
      fill_in 'diabetic_name', :with => 'John Doe'
      select("2013",:from=> "diabetic_birthday_1i")
      select("March",:from=> "diabetic_birthday_2i")
      select("24",:from=> "diabetic_birthday_3i")
      fill_in 'diabetic_email', :with => 'doe@doe.com'
      click_on "Create"
      expect(page).to have_content "Doctor Creation"
    end

    it "brings you to account dashboard after clicking cancel" do
      visit root_path
      click_on "Sign up !"
      fill_in "Username", with: 'Mo'
      fill_in "Email", with: 'mo@business.com'
      fill_in "Password", with: 'testing'
      fill_in "Password Confirmation", with: 'testing'
      click_on "Sign up"
      click_on "Cancel"
      expect(page).to have_content "Mo's Dashboard"
    end
  end

end
