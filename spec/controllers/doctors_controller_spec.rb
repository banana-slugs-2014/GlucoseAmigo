require 'spec_helper'

describe DoctorsController do
  let(:doctor) { create :doctor }
  let!(:account) { create :account }
  let(:doc_attr) { attributes_for :doctor }

	let!(:pre_created_doctor) { create :doctor }
  let!(:pre_created_doc_attr) { attributes_for :doctor }
	let(:diabetic) { create :diabetic }

	before(:each) do
		#account = create :account
		request.session[:account_id] = account.id
	end

  context "#index" do
    xit "should successfully render a page" do
      get :index, diabetic_id: diabetic.id
      expect(response).to be_success
    end

    xit 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:account_id)
      get :index, diabetic_id: diabetic.id
      expect(response).to be_redirect
    end
  end

  context "#show" do
    xit "should successfully render a page" do
    	get :show, id: doctor.id, diabetic_id: diabetic.id
      expect(response).to be_success
    end
    xit "should display this specific doctor" do
      get :show, id: doctor.id, diabetic_id: diabetic.id
      expect(assigns(:doctor)).to eq(doctor)
    end

    xit 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:account_id)
      get :show, id: doctor.id, diabetic_id: diabetic.id
      expect(response).to be_redirect
    end
  end

  context "#new" do
    it "should successfully render a page" do
    	get :new, diabetic_id: diabetic.id
      expect(response).to be_success
    end

    it 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:account_id)
      get :new, diabetic_id: diabetic.id
      expect(response).to be_redirect
    end
  end

  context "#create" do
    it "should increase doctor count if doctor name and fax don't already exist" do
      expect{
        post :create, doctor: doc_attr, diabetic_id: diabetic.id
      }.to change{Doctor.count}.by(1)
    end
    it "should not increase doctor count if doctor name and fax already exists" do
      new_doctor = Doctor.create(doc_attr)
      expect{
        post :create, doctor: { name: new_doctor.name, fax: new_doctor.fax }, diabetic_id: diabetic.id
      }.to change{Doctor.count}.by(0)
    end
  end

  context "#edit" do
  	it "should render edit page with the right doctor" do
  		get :edit, id: doctor.id, diabetic_id: diabetic.id
  		expect(response).to be_success
  		expect(assigns(:doctor)).to eq(doctor)
  	end
  end

  context "#update" do
  	it "should update target doctor info and redirect to show that doctor" do
  		new_email = doctor.email
  		new_comments = doctor.comments
  		post :update, id: pre_created_doctor.id,
										diabetic_id: diabetic.id,
										doctor: {email: new_email, comments: new_comments}

  		expect(pre_created_doctor.email).to eq(new_email)
  		expect(pre_created_doctor.comments).to eq(new_comments)
  	end

  	it "should not update target doctor info into an existing name-fax pair" do
  		existing_name = pre_created_doctor.name
  		existing_fax = pre_created_doctor.fax
  		curr_name = doctor.name
  		curr_fax = doctor.fax
  		post :update, doctor: {name: existing_name, fax: existing_fax},
										id: doctor.id,
										diabetic_id: diabetic.id

  		expect(doctor.name).to_not eq(existing_name)
  		expect(doctor.fax).to_not eq(existing_fax)
  		expect(doctor.name).to eq(curr_name)
  		expect(doctor.fax).to eq(curr_fax)
  	end
    it "should render edit page with the right doctor" do
      get :edit, id: doctor.id, diabetic_id: diabetic.id
      expect(response).to be_success
      expect(assigns(:doctor)).to eq(doctor)
    end

     it 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:account_id)
      get :edit, id: doctor.id, diabetic_id: diabetic.id
      expect(response).to be_redirect
    end
  end

  context "#update" do
    it "should update target doctor info and redirect to show that doctor" do
      new_email = doctor.email
      new_comments = doctor.comments
      post :update, doctor: {email: new_email, comments: new_comments}, id: pre_created_doctor.id, diabetic_id: diabetic.id
      expect(pre_created_doctor.email).to eq(new_email)
      expect(pre_created_doctor.comments).to eq(new_comments)
    end

    it "should not update target doctor info into an existing name-fax pair" do
      existing_name = pre_created_doctor.name
      existing_fax = pre_created_doctor.fax
      curr_name = doctor.name
      curr_fax = doctor.fax
      post :update, doctor: {name: existing_name, fax: existing_fax}, id: doctor.id, diabetic_id: diabetic.id
      expect(doctor.name).to_not eq(existing_name)
      expect(doctor.fax).to_not eq(existing_fax)
      expect(doctor.name).to eq(curr_name)
      expect(doctor.fax).to eq(curr_fax)
    end
  end
end
