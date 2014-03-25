require 'spec_helper'

def wait_for_ajax
  Timeout.timeout(Capybara.default_wait_time) do
    loop until finished_all_ajax_requests?
  end
end

def finished_all_ajax_requests?
  page.evaluate_script('jQuery.active').zero?
end



describe "dashboard", js: true  do
	let(:doctor) { create :doctor }
	let(:diabetic) { create :diabetic }
	let(:diabetic_attr) {  attributes_for :diabetic }

	before(:each) do
		@account = create :account
		doctor.diabetics << diabetic
		@account.diabetics << diabetic
    visit new_session_path
    fill_in "Username", with: 'test'
    fill_in "Password", with: 'testing'
    click_on "Log in"
    wait_for_ajax
	end


  describe "User reaches the dashboard" do
    it "by logging in an existing account" do
      expect(page).to have_css("form")
      expect(page).to have_css("select")
      expect(page.body).to have_content("Dashboard")
    end
  end

  describe "User can log out from the dashboard" do
    xit "by clicking on 'Logout'" do
    	click_on "Logout"
    	wait_for_ajax
    	expect(page.current_path).to eq root_path
    end
  end


	context "with account" do
		xit "user can edit the account information" do
			find("option[value='Account: #{@account.username}']").click
			click_on "Edit the account"
			wait_for_ajax
			fill_in "account[username]", with: "tester_username_that_should_be_new"
			fill_in "account[email]", with: "tester_email@should_be_new.com"
			fill_in "account[password]", with: "testing"
			fill_in "account[password_confirmation]", with: "testing"
			click_on "Save"
			wait_for_ajax
			expect(@account.reload.username).to eq("tester_username_that_should_be_new")
			expect(@account.reload.email).to eq("tester_email@should_be_new.com")
		end

		it "user can cancel the edit the account information" do
			find("option[value='Account: #{@account.username}']").click
			wait_for_ajax
			click_on "Edit the account"
			wait_for_ajax
			click_on "Cancel"
			wait_for_ajax
			expect(page.body).to have_content("Dashboard")
		end

		it "user can add a diabetic" do
			find("option[value='Account: #{@account.username}']").click
			click_on "Add a Diabetic"
			wait_for_ajax
			expect{
				fill_in "diabetic[name]", with: diabetic_attr[:name]
				fill_in "diabetic[email]", with: diabetic_attr[:email]
				within '#diabetic_birthday_1i' do
					find("option[value='2009']").click
				end
				click_on "Create"
				wait_for_ajax
			}.to change{Diabetic.count}.by(1)
			#p Diabetic.count
			#p Diabetic.count
			#expect{click_on "Create"}.to change{@account.diabetics.count}.by(1)
			expect(@account.diabetics.last.name).to eq(diabetic_attr[:name])
			expect(@account.diabetics.last.email).to eq(diabetic_attr[:email])
		end

		it "user can cancel the add a diabetic" do
			find("option[value='Account: #{@account.username}']").click
			click_on "Add a Diabetic"
			wait_for_ajax
			click_on "Cancel"
			wait_for_ajax
			expect(page.body).to have_content("Dashboard")
		end
	end

	context "with diabetics" do
		it "can add a record for diabetic" do
			diabetic_name = @account.diabetics.first.name
			diabetic_id = @account.diabetics.first.id
			find("option[value='Diabetic: #{diabetic_name} -- #{diabetic_id} ']").click
			click_on "Add a record for: #{@account.diabetics.first.name}"
			wait_for_ajax
			weight = rand(175..230)
			glucose = rand(200..600)
			fill_in "record[weight]", with: weight
			fill_in "record[glucose]", with: glucose
			fill_in "record[comment]", with: "test_comment"
			expect{
				click_on "Add"
				wait_for_ajax
				}.to change{Record.count}.by(1)
			expect(@account.diabetics.first.records.last.weight.to_i).to eq(weight)
			expect(@account.diabetics.first.records.last.glucose.to_i).to eq(glucose)
			expect(@account.diabetics.first.records.last.comment).to eq("test_comment")
		end

		it "can view a record for diabetic" do
			diabetic_name = @account.diabetics.first.name
			diabetic_id = @account.diabetics.first.id
			find("option[value='Diabetic: #{diabetic_name} -- #{diabetic_id} ']").click
		end

		it "can edit the diabetic's info" do
			diabetic_name = @account.diabetics.first.name
			diabetic_id = @account.diabetics.first.id
			find("option[value='Diabetic: #{diabetic_name} -- #{diabetic_id} ']").click

		end



	end

end








