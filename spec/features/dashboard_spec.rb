require 'spec_helper'

describe "dashboard", js: true  do
	let(:doctor) { create :doctor }
	let(:diabetic) { create :diabetic }

	before(:each) do
		@account = create :account
		doctor.diabetics << diabetic
		@account.diabetics << diabetic
    visit new_session_path
    fill_in "Username", with: 'test'
    fill_in "Password", with: 'testing'
    click_on "Log in"
	end


  describe "User reaches the dashboard" do
    it "by logging in an existing account" do
    	# p find("#logout-button")#.trigger("click")
    	#page.select('Selenium Core', :from => 'selecttype')
#     within '#date' do
#   		find("option[value='20120905']").click
# 		end
      expect(page).to have_css("form")
      expect(page).to have_css("select")
      expect(page.body).to have_content("Dashboard")
			page.should have_selector(:link_or_button, 'Log out')
    end
  end

  describe "User can log out from the dashboard" do
    it "by clicking on 'Logout'" do
    	click_on "Logout"
    	expect(page.current_path).to eq root_path
    end
  end


	context "with account" do
		it "user can edit the account information" do
			find("option[value='Account: #{@account.username}']").click
			click_on "Edit the account"
			fill_in "account[username]", with: "tester_username_that_should_be_new"
			fill_in "account[email]", with: "tester_email@should_be_new.com"
			click_on "Save"
			expect(@account.reload.username).to eq("tester_username_that_should_be_new")
			expect(@account.reload.email).to eq("tester_email@should_be_new.com")
		end

		it "user can cancel the edit the account information" do
			find("option[value='Account: #{@account.username}']").click
			click_on "Edit the account"
			click_on "Cancel"
		end

		it "user can add a diabetic" do
			find("option[value='Account: #{@account.username}']").click
		
		end
	end

end