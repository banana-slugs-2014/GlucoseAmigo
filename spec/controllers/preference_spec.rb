require 'spec_helper'

describe PreferencesController do
  let(:diabetic) {create :diabetic }
  let!(:pre_created_diabetic) { create :diabetic }
  let(:preference) { create :preference }
  let!(:pre_created_pref) { create :preference }
  let(:pref_attr) { attributes_for :preference }

  context "#new" do
    it "should successfully render a page for a diabetic" do
      get :new, diabetic_id: diabetic.id
      expect(response).to be_success
      expect(assigns(:diabetic)).to eq(diabetic)
      # puts "=========================="
      # p current_path
      # p current_url
    end
  end

  context "#show" do
    it "should successfully render a page" do
      diabetic.preference = preference
      diabetic.save
      get :show, id: diabetic.preference.id, diabetic_id: diabetic.id
      expect(response).to be_success
    end
    it "should display this specific doctor" do
      diabetic.preference = preference
      diabetic.save
      get :show, id: diabetic.preference.id, diabetic_id: diabetic.id
      expect(assigns(:diabetic)).to eq(diabetic)
      expect(assigns(:preference)).to eq(preference)
    end
  end



end

  # before(:each) do
  #   @account = create :account
  #   @diabetic = @account.diabetics.new( name: CoolFaker::Character.name,
  #                                       email: Faker::Internet.email,
  #                                     )
  #   @diabetic.birth_date = {
  #                             year: (Date.today.year - 10 - rand(5)),
  #                             month: Date.today.month,
  #                             day: Date.today.day
  #                           }
  #   @diabetic.save
  #   request.session[:user_id] = @account.id
  # end







  # context "#create" do
  #   it "should increase doctor count if doctor name and fax don't already exist" do
  #     expect{
  #       post :create, doctor: doc_attr, diabetic_id: @diabetic.id
  #     }.to change{Doctor.count}.by(1)
  #   end
  #   it "should not increase doctor count if doctor name and fax already exists" do
  #       new_doctor = Doctor.create(doc_attr)
  #     expect{
  #       post :create, doctor: { name: new_doctor.name, fax: new_doctor.fax }, diabetic_id: @diabetic.id
  #     }.to change{Doctor.count}.by(0)
  #   end
  # end

  # context "#edit" do
  #   it "should render edit page with the right doctor" do
  #     get :edit, id: doctor.id, diabetic_id: @diabetic.id
  #     expect(response).to be_success
  #     expect(assigns(:doctor)).to eq(doctor)
  #   end
  # end

  # context "#update" do
  #   it "should update target doctor info and redirect to show that doctor" do
  #     new_email = doctor.email
  #     new_comments = doctor.comments
  #     post :update, id: pre_created_doctor.id,
  #                   diabetic_id: @diabetic.id,
  #                   doctor: {email: new_email, comments: new_comments}

  #     expect(pre_created_doctor.email).to eq(new_email)
  #     expect(pre_created_doctor.comments).to eq(new_comments)
  #   end

  #   it "should not update target doctor info into an existing name-fax pair" do
  #     existing_name = pre_created_doctor.name
  #     existing_fax = pre_created_doctor.fax
  #     curr_name = doctor.name
  #     curr_fax = doctor.fax
  #     post :update, doctor: {name: existing_name, fax: existing_fax},
  #                   id: doctor.id,
  #                   diabetic_id: @diabetic.id

  #     expect(doctor.name).to_not eq(existing_name)
  #     expect(doctor.fax).to_not eq(existing_fax)
  #     expect(doctor.name).to eq(curr_name)
  #     expect(doctor.fax).to eq(curr_fax)
  #   end
  # end