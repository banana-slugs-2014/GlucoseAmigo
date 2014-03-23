require 'spec_helper'

describe "doctors" do
	let(:doctor) { create :doctor }
	let!(:pre_created_doctor) { create :doctor }
	let(:doc_attr) { attributes_for :doctor }
	let!(:pre_created_doc_attr) { attributes_for :doctor }

	before(:each) do
		@account = create :account
		@diabetic = @account.diabetics.new(	name: CoolFaker::Character.name,
																				email: Faker::Internet.email,
																			)
		@diabetic.birth_date = {
															year: (Date.today.year - 10 - rand(5)),
															month: Date.today.month,
															day: Date.today.day
														}
		@diabetic.save
	end


  describe "User can see base page" do
<<<<<<< HEAD
    it "by visting the doctors page" do
      visit diabetic_doctors_path(diabetic_id: @diabetic.id)
=======
    xit "by visting the doctors page" do
      visit doctors_path
>>>>>>> adds passing logged_in/logged_out diabetics controller tests
      expect(page.status_code).to eq(200)
    end
  end

  describe "User can visit a doctor creation page" do
<<<<<<< HEAD
    it "by clicking on create 'a new doctor'" do
      visit diabetic_doctors_path(diabetic_id: @diabetic.id)
=======
    xit "by clicking on create 'a new doctor'" do
      visit doctors_path
>>>>>>> adds passing logged_in/logged_out diabetics controller tests
      click_on "Create a New Doctor"
      expect(page.status_code).to eq(200)
      expect(page).to have_css("form")
    end
    context "with valid parameters" do
      xit "should be able to create a new doctor if it doesn't already exist" do
        expect{
          visit new_diabetic_doctor_path(diabetic_id: @diabetic.id)
          fill_in "doctor[name]", with: doc_attr[:name]
          fill_in "doctor[fax]", with: doc_attr[:fax]
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(1)
      end
    end
    context "with invalid parameters" do
      xit "should not able to create a new doctor if name field is empty" do
        expect{
					visit new_diabetic_doctor_path(diabetic_id: @diabetic.id)
          fill_in "doctor[fax]", with: doc_attr[:fax]
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(0)
      end
      xit "should not able to create a new doctor if fax field is empty" do
        expect{
					visit new_diabetic_doctor_path(diabetic_id: @diabetic.id)
          fill_in "doctor[name]", with: doc_attr[:name]
          fill_in "doctor[email]", with: doc_attr[:email]
          fill_in "doctor[comments]", with: doc_attr[:comments]
          click_on "Save Doctor"
        }.to change{Doctor.count}.by(0)
      end
      xit "should not able to create a doctor with already existing name and fax combination" do
        expect{
					visit new_diabetic_doctor_path(diabetic_id: @diabetic.id)
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
<<<<<<< HEAD
      it "by clicking on edit" do
        visit edit_diabetic_doctor_path(@diabetic, pre_created_doctor)
=======
      xit "by clicking on edit" do
        visit edit_doctor_path(pre_created_doctor)
>>>>>>> adds passing logged_in/logged_out diabetics controller tests
        fill_in "doctor[name]", with: doc_attr[:name]
        fill_in "doctor[fax]", with: doc_attr[:fax]
        fill_in "doctor[email]", with: doc_attr[:email]
        fill_in "doctor[comments]", with: doc_attr[:comments]

        click_on "Save Doctor"
<<<<<<< HEAD

        expect(current_path).to eq diabetic_doctor_path(@diabetic, pre_created_doctor)
=======
        expect(current_path).to eq doctor_path(pre_created_doctor)
>>>>>>> adds passing logged_in/logged_out diabetics controller tests
        expect(page).to have_content doc_attr[:name]
        expect(page).to have_content doc_attr[:fax]
        expect(page).to have_content doc_attr[:email]
        expect(page).to have_content doc_attr[:comments]
      end
    end
  end
end
