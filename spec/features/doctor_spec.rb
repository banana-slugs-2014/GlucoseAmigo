require 'spec_helper'

describe "doctors" do

	let(:doctor) { create :doctor }
	let(:doc_attr) { attributes_for :doctor }

	let!(:pre_created_doctor) { create :doctor }
	let!(:pre_created_doc_attr) { attributes_for :doctor }
	let!(:diabetic) { create :diabetic }

	before(:each) do
		@account = create :account
    visit new_session_path
    fill_in "Username", with: 'test'
    fill_in "Password", with: 'testing'
    click_on "Log in"
	end


  describe "User can see base page" do
    it "by visting the doctors page" do
      visit diabetic_doctors_path(diabetic_id: diabetic.id)
      expect(page.status_code).to eq(200)
    end
  end

  describe "User can visit a doctor creation page" do
    it "by clicking on create 'a new doctor'" do
      visit diabetic_doctors_path(diabetic_id: diabetic.id)
      click_on "Create a New Doctor"
      expect(page.status_code).to eq(200)
      expect(page).to have_css("form")
    end
    context "with valid parameters" do
      it "should be able to create a new doctor if it doesn't already exist" do
        expect{
          visit new_diabetic_doctor_path(diabetic_id: diabetic.id)
          fill_in "doctor[name]", with: doc_attr[:name]
          fill_in "doctor[fax]", with: doc_attr[:fax]
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(1)
      end
    end
    context "with invalid parameters" do
      it "should not able to create a new doctor if name field is empty" do
        expect{
					visit new_diabetic_doctor_path(diabetic_id: diabetic.id)
          fill_in "doctor[fax]", with: doc_attr[:fax]
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(0)
      end
      it "should not able to create a new doctor if fax field is empty" do
        expect{
					visit new_diabetic_doctor_path(diabetic_id: diabetic.id)
          fill_in "doctor[name]", with: doc_attr[:name]
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(0)
      end
      it "should not able to create a doctor with already existing name and fax combination" do
        expect{
					visit new_diabetic_doctor_path(diabetic_id: diabetic.id)
          fill_in "doctor[name]", with: pre_created_doctor.name
          fill_in "doctor[fax]", with: pre_created_doctor.fax
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(0)
      end
    end
  end

  describe "User can edit an existing question" do
    context "with valid parameters" do
      it "by clicking on edit" do
        visit edit_diabetic_doctor_path(diabetic, pre_created_doctor)
        fill_in "doctor[name]", with: doc_attr[:name]
        fill_in "doctor[fax]", with: doc_attr[:fax]
        fill_in "doctor[email]", with: doc_attr[:email]
        fill_in "doctor[comments]", with: doc_attr[:comments]

        click_on "Save Doctor"
        expect(current_path).to eq diabetic_doctor_path(diabetic, pre_created_doctor)
        expect(page).to have_content doc_attr[:name]
        expect(page).to have_content doc_attr[:fax]
        expect(page).to have_content doc_attr[:email]
        expect(page).to have_content doc_attr[:comments]
      end
    end
  end
end
