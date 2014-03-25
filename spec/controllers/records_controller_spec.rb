require 'spec_helper'
require 'date'

describe RecordsController do
  let!(:account) {create :account}
  before :each do
      # use let, it's preferred
      @chris = Diabetic.create({name:'chris', email:'chris@dbc.com', birthday: Date.today-20000 }, :without_protection => true)
      @record1 = Record.create(glucose: '100', weight: '175', taken_at: (Time.now-500))
      @chris.records << @record1
      request.session[:user_id] = account.id
  end


  context '#index' do
    it "gets a users records" do
      get :index, diabetic_id: @chris.id
      expect(response).to be_success
    end

    it 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:user_id)
      get :index, diabetic_id: @chris.id
      expect(response).to be_redirect
    end
  end

  context '#show' do
    it 'shows a single record' do
      get :show, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_success
    end

    it 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:user_id)
      get :show, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_redirect
    end
  end

  context '#edit' do
    it 'shows an edit page' do
      get :edit, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_success
    end

    it 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:user_id)
      get :edit, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_redirect
    end
  end

  context '#new' do
    it "shows a form for a new record" do
      get :new, diabetic_id: @chris.id
      expect(response).to be_success
    end

    it 'redirects if logged_out' do
      request.env["HTTP_REFERER"] = new_session_path
      request.session.delete(:user_id)
      get :new, diabetic_id: @chris.id
      expect(response).to be_redirect
    end
  end

  context '#update' do
    it 'updates a single record' do
      put :update, diabetic_id: @chris.id, id: @record1.id, record: {glucose: '120', weight: '176', taken_at: Time.now-500, comment: "I just got updated!"}
      expect(response).to be_redirect
    end
  end


  context '#create' do
    it "creates a new record given valid params" do

      expect {post :create, diabetic_id: @chris.id, record: {glucose: '115', weight: '174', taken_at: (Time.now-500), comment: "I just got created!"}}.to change {Record.all.count }.by(1)
    end

    it "does not create a new Record with invalid params" do
      expect {post :create, diabetic_id: @chris.id, record: {glucose:nil, weight: nil, taken_at: (Time.now() + (60*60*24))} }.to_not change { Record.all.count }
    end

  end


  context '#delete' do
    it 'should let a user delete a record' do

      expect{ delete :destroy, diabetic_id: @chris.id, id: @record1.id }.to change { Record.all.count }.by(-1)
    end
  end

  context '#index.pdf' do
    it "downloads a pdf with the user's records" do
      request.env["SERVER_PROTOCOL"] = "http"
      get :index, diabetic_id: @chris.id, "format" => "pdf"
      response.header.should have_content("#{@chris.name}_#{Date.today.to_s}")
      response.header.should have_content("application/pdf")
    end
  end



end
