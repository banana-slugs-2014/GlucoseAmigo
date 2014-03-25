require 'spec_helper'
describe "Accounts", :js => true do
  let!(:account) {create :account}

  context "Sign in" do
    it "displays the sign in page" do
      visit root_path
      click_on "Sign up !"
      expect(page).to have_content "Username"
    end

    it 'brings you to add a diabetic page' do
      visit root_path
      click_on "Sign up !"
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'business'
      fill_in "Password Confirmation", with: 'business'
      click_on "Sign up"
      expect(page).to have_content 'Add a diabetic'
    end

    xit "displays 'Username can't be blank' for blank Username field" do
      visit new_account_path
      fill_in "Username", with: ''
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'business'
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content "Username can't be blank"
    end

    xit "displays 'Email can't be blank' for blank Email field" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: ''
      fill_in "Password", with: 'business'
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content "Email can't be blank"
    end

    xit "displays 'Password can't be blank' for blank Password field" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: ''
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content "Password can't be blank"
    end

    xit "displays 'Password too short' for Password field less than 5 char" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'test'
      fill_in "Password Confirmation", with: 'test'
      click_on "Signup"
      expect(page).to have_content "Password is too short (minimum is 5 characters)"
    end

    xit "displays 'Password doesn't match confirmation' for non-matching pw fields" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'testing'
      fill_in "Password Confirmation", with: 'test'
      click_on "Signup"
      expect(page).to have_content "Password doesn't match confirmation"
    end

    context "cancel button" do
      it "brings you back to home page" do
        visit root_path
        click_on "Sign up"
        click_on "Cancel"
        expect(page).to have_content "Welcome to Glucose Amigo!"
      end
    end

  end
end