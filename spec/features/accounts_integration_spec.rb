require 'spec_helper'
describe "Accounts", :js => true do
  let!(:account) {create :account}

  context "signin form" do
    it 'displays sign in form' do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'business'
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content 'Enter your birthday'
    end

    it "displays 'Username can't be blank' for blank Username field" do
      visit new_account_path
      fill_in "Username", with: ''
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'business'
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content "Username can't be blank"
    end

    it "displays 'Email can't be blank' for blank Email field" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: ''
      fill_in "Password", with: 'business'
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content "Email can't be blank"
    end

    it "displays 'Password can't be blank' for blank Password field" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: ''
      fill_in "Password Confirmation", with: 'business'
      click_on "Signup"
      expect(page).to have_content "Password can't be blank"
    end

    it "displays 'Password too short' for Password field less than 5 char" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'test'
      fill_in "Password Confirmation", with: 'test'
      click_on "Signup"
      expect(page).to have_content "Password is too short (minimum is 5 characters)"
    end

    it "displays 'Password doesn't match confirmation' for non-matching pw fields" do
      visit new_account_path
      fill_in "Username", with: 'business'
      fill_in "Email", with: 'business@business.com'
      fill_in "Password", with: 'testing'
      fill_in "Password Confirmation", with: 'test'
      click_on "Signup"
      expect(page).to have_content "Password doesn't match confirmation"
    end

  end

end


#   let!(:user) { create :user }

#   context "signup" do
#     it "displays signin form" do
#       visit root_path
#       click_on 'sign up'
#       expect(page).to have_button 'Signup'
#     end
#     it "brings you to question page after sign up" do
#       visit new_user_path
#       fill_in "Username", :with => "business"
#       fill_in "Email", :with => "business@now.com"
#       fill_in "Password", :with => "business"
#       fill_in "Password Confirmation", :with => "business"
#       click_on 'Signup'
#       expect(page).to have_link 'Ask a Question'
#     end
#   end

#   context "login" do
#     it 'brings you to login page' do
#       visit root_path
#       click_on 'log in'
#       expect(page).to have_button 'Login'
#     end
#     it 'brings you to question page after login' do
#       visit users_path
#       fill_in "Email", :with => user.email
#       fill_in "Password", :with => user.password
#       click_on 'Login'
#       expect(page).to have_link 'Ask a Question'
#     end
#   end

#   context 'home button' do
#     it 'brings you to home page' do
#        visit users_path
#        my_link = find(:xpath, "//a[contains(@href,'/questions')]")
#        my_link.click
#        expect(page).to have_link 'Ask a Question'
#     end
#   end

#   context 'logout' do
#     it 'brings you back to login page' do
#       visit users_path
#       fill_in "Email", :with => user.email
#       fill_in "Password", :with => user.password
#       click_on 'Login'
#       click_on 'log out'
#       expect(page).to have_button 'Login'
#     end
#   end

# end



#describe "Users", :js => true do
#   let!(:user) { User.create(username: 'test',
#                             email: 'test@test.com',
#                             password: 'testing',
#                             password_confirmation: 'testing')}
#   context "homepage" do
#     it "displays login form" do
#       visit root_path
#       expect(page).to have_link 'log in'
#     end

#     it "displays login form" do
#       visit root_path
#       expect(page).to have_link 'sign up'
#     end
#   end
