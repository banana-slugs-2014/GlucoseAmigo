require 'spec_helper'

#after all tests, add an expect to expect you are redirected to the right page
#may want to add an cancle button test to all, maybe in a new spec file called "cancle test"?

describe "dashboard", js: true  do
	let(:doctor) { create :doctor }
	let(:doctor_attr) { attributes_for :doctor}
	let(:diabetic) { create :diabetic }
	let(:diabetic_attr) {  attributes_for :diabetic }
	let(:record) { create :record }

	before(:each) do
		@account = create :account
		doctor.diabetics << diabetic
		@account.diabetics << diabetic
		@diabetic = @account.diabetics.last
		@diabetic.records << record
    visit new_session_path
    fill_in "Username", with: 'test'
    fill_in "Password", with: 'testing'
    click_on "Log in"
    wait_for_ajax
	end


	#I might not want/need this one
  describe "User reaches the dashboard" do
    it "by logging in an existing account" do
      expect(page).to have_css("form")
      expect(page).to have_css("select")
      expect(page.body).to have_content("Dashboard")
    end
  end

  #need this one, might be doing it wrong though
  describe "User can log out from the dashboard" do
    it "by clicking on 'Logout'" do
    	click_on "Logout"
    	wait_for_ajax
    	expect(page.current_path).to eq root_path
    end
  end


	context "with account" do
		it "user can edit the account information" do
			find("option[value='Account: #{@account.username}']").click
			click_on "Edit the account"
			wait_for_ajax
			fill_in "account[username]", with: "tester_username_that_should_be_new"
			fill_in "account[email]", with: "tester_email@should_be_new.com"
			fill_in "account[password]", with: "testing"
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
			#Adds a diabetic
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
			expect(@account.diabetics.last.name).to eq(diabetic_attr[:name])
			expect(@account.diabetics.last.email).to eq(diabetic_attr[:email])

			#Adds a doctor to the diabetic
			fill_in "doctor[name]", with: doctor_attr[:name]
			fill_in "doctor[fax]", with: doctor_attr[:fax]
			fill_in "doctor[email]", with: doctor_attr[:email]
			fill_in "doctor[comments]", with: doctor_attr[:comments]
			click_on "Save Doctor"
			wait_for_ajax
			expect(@account.diabetics.last.doctor.name).to eq(doctor_attr[:name])
			expect(@account.diabetics.last.doctor.fax).to eq(doctor_attr[:fax])
			expect(@account.diabetics.last.doctor.email).to eq(doctor_attr[:email])
			expect(@account.diabetics.last.doctor.comments).to eq(doctor_attr[:comments])

			#adds preference to diabetic
			choose "preference_reminders_false"
			find("option[value='2']").click
			click_on "Save"
			wait_for_ajax
			expect(@account.diabetics.last.preference.reminders).to eq(false)
			expect(@account.diabetics.last.preference.frequency).to eq(2)
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

		#feature doesn't work atm, known issue, will update after bug fix
		xit "can view a record for diabetic" do
			diabetic_name = @account.diabetics.first.name
			diabetic_id = @account.diabetics.first.id
			find("option[value='Diabetic: #{diabetic_name} -- #{diabetic_id} ']").click
			wait_for_ajax
			click_on "View records for #{diabetic_name}"
			wait_for_ajax

		end

		context "edit the diabetic's info" do
			before(:each) do
				diabetic_name = @diabetic.name
				diabetic_id = @diabetic.id
				find("option[value='Diabetic: #{diabetic_name} -- #{diabetic_id} ']").click
				wait_for_ajax
				click_on "Edit #{diabetic_name}'s info"
				wait_for_ajax
			end

			it "can edit preferences" do
				click_on "Add Preferences"
				wait_for_ajax
				choose "preference_reminders_false"
				find("option[value='2']").click
				click_on "Save"
				wait_for_ajax
				expect(@diabetic.preference.reminders).to eq(false)
				expect(@diabetic.preference.frequency).to eq(2)
			end

			it "can edit user info" do
				click_on "Edit User Info"
				wait_for_ajax
				expect{
					fill_in "diabetic[name]", with: diabetic_attr[:name]
					fill_in "diabetic[email]", with: diabetic_attr[:email]
					within '#diabetic_birthday_1i' do
						find("option[value='2009']").click
					end
					click_on "Save"
					wait_for_ajax
				}.to change{Diabetic.count}.by(0)
				expect(@account.diabetics.last.name).to eq(diabetic_attr[:name])
				expect(@account.diabetics.last.email).to eq(diabetic_attr[:email])
			end

			it "can edit doctor info" do
				click_on "Edit Doctor Info"
				wait_for_ajax
				fill_in "doctor[name]", with: doctor_attr[:name]
				fill_in "doctor[fax]", with: doctor_attr[:fax]
				fill_in "doctor[email]", with: doctor_attr[:email]
				fill_in "doctor[comments]", with: doctor_attr[:comments]
				click_on "Save Doctor"
				wait_for_ajax
				expect(@diabetic.doctor.name).to eq(doctor_attr[:name])
				expect(@diabetic.doctor.fax).to eq(doctor_attr[:fax])
				expect(@diabetic.doctor.email).to eq(doctor_attr[:email])
				expect(@diabetic.doctor.comments).to eq(doctor_attr[:comments])
			end
		end
	end

end








