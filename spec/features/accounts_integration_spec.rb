require 'spec_helper'


describe "Accounts", :js => true do
  let!(:account) {create :account}
  let(:diabetic) {create :diabetic}
  let(:diabetic_attr) {  attributes_for :diabetic }
  let(:doctor_attr) {  attributes_for :doctor }

  describe "full account creation process" do
    it 'allows user to create an account with sign up' do
      visit root_path
      click_on "Sign Up"
      wait_for_ajax
      expect{
        fill_in "Username", with: 'business'
        fill_in "Email", with: 'business@business.com'
        fill_in "Password", with: 'business'
        fill_in "Password Confirmation", with: 'business'
        click_on "Sign up"
        wait_for_ajax
      }.to change{Account.count}.by(1)
      expect(page).to have_content 'Add a diabetic'
      expect(Account.last.username).to eq('business')
      expect(Account.last.email).to eq('business@business.com')

      new_account = Account.last

      expect{
        fill_in "diabetic[name]", with: diabetic_attr[:name]
        fill_in "diabetic[email]", with: diabetic_attr[:email]
        find("option[value='2009']").click
        click_on "Create"
        wait_for_ajax
      }.to change{Diabetic.count}.by(1)
      expect(new_account.diabetics.last.name).to eq(diabetic_attr[:name])
      expect(new_account.diabetics.last.email).to eq(diabetic_attr[:email])
      expect(page).to have_content 'Create a Doctor'

      expect{
        fill_in "doctor[name]", with: doctor_attr[:name]
        fill_in "doctor[fax]", with: doctor_attr[:fax]
        fill_in "doctor[email]", with: doctor_attr[:email]
        fill_in "doctor[comments]", with: doctor_attr[:comments]
        click_on "Save Doctor"
        wait_for_ajax
      }.to change{Doctor.count}.by(1)
      expect(new_account.reload.diabetics.last.doctor.name).to eq(doctor_attr[:name])
      expect(new_account.reload.diabetics.last.doctor.fax).to eq(doctor_attr[:fax])
      expect(new_account.reload.diabetics.last.doctor.email).to eq(doctor_attr[:email])
      expect(new_account.reload.diabetics.last.doctor.comments).to eq(doctor_attr[:comments])
      expect(page).to have_content 'preferences'

      expect{
        find("option[value='2']").click
        click_on "Save"
        wait_for_ajax
      }.to change{Preference.count}.by(1)
      expect(new_account.reload.diabetics.last.preference.reminders).to eq(true)
      expect(new_account.reload.diabetics.last.preference.frequency).to eq(2)
      expect(page).to have_content 'Dashboard'


    end
  end


  context "signup form" do
    xit 'allows user to create an account with sign up' do
      visit root_path
      click_on "Sign Up"
      wait_for_ajax
      expect{
        fill_in "Username", with: 'business'
        fill_in "Email", with: 'business@business.com'
        fill_in "Password", with: 'business'
        fill_in "Password Confirmation", with: 'business'
        click_on "Sign up"
        wait_for_ajax
      }.to change{Account.count}.by(1)
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

  end

end

