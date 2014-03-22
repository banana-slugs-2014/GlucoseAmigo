require 'spec_helper'

describe DoctorsController do
	let(:doctor) { create :doctor }
	let!(:pre_created_doctor) { create :doctor }
	let(:doc_attr) { attributes_for :doctor }
	let!(:pre_created_doc_attr) { attributes_for :doctor }

  context "#index" do
    it "should successfully render a page" do
    	get :index
      expect(response).to be_success
    end
  end

  context "#show" do
    it "should successfully render a page" do
    	get :show, id: doctor.id
      expect(response).to be_success
    end
    it "should display this specific doctor" do
      get :show, id: doctor.id
      expect(assigns(:doctor)).to eq(doctor)
    end
  end

  context "#new" do
    it "should successfully render a page" do
    	get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    it "should increase doctor count if doctor name and fax don't already exist" do
      expect{
        post :create, doctor: doc_attr
      }.to change{Doctor.count}.by(1)
    end
    it "should not increase doctor count if doctor name and fax already exists" do
        new_doctor = Doctor.create(doc_attr)
      expect{
        post :create, doctor: { name: new_doctor.name, fax: new_doctor.fax }
      }.to change{Doctor.count}.by(0)
    end
  end

  context "#edit" do
  	it "should render edit page with the right doctor" do
  		get :edit, id: doctor.id
  		expect(response).to be_success
  		expect(assigns(:doctor)).to eq(doctor)
  	end
  end

  context "#update" do
  	it "should update target doctor info and redirect to show that doctor" do
  		new_email = doctor.email
  		new_comments = doctor.comments
  		post :update, doctor: {email: new_email, comments: new_comments}, id: pre_created_doctor.id
  		expect(pre_created_doctor.email).to eq(new_email)
  		expect(pre_created_doctor.comments).to eq(new_comments)
  	end

  	it "should not update target doctor info into an existing name-fax pair" do
  		existing_name = pre_created_doctor.name
  		existing_fax = pre_created_doctor.fax
  		curr_name = doctor.name
  		curr_fax = doctor.fax
  		post :update, doctor: {name: existing_name, fax: existing_fax}, id: doctor.id
  		expect(doctor.name).to_not eq(existing_name)
  		expect(doctor.fax).to_not eq(existing_fax)
  		expect(doctor.name).to eq(curr_name)
  		expect(doctor.fax).to eq(curr_fax)
  	end
  end
end