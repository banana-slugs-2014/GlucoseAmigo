require 'spec_helper'

describe RecordsController do
  before :each do
      @chris = Diabetic.create({name:'chris', email:'chris@dbc.com', age:'27'}, :without_protection => true)
      @record1 = Record.create(glucose: '100', weight: '175', taken_at: (Time.now-500))
      @chris.records << @record1
  end


  context '#index' do
    it "gets a users records" do
      get :index, diabetic_id: @chris.id
      expect(response).to be_success
    end
  end

  context '#show' do
    it 'shows a single record' do
      get :show, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_success
    end
  end

  context '#edit' do
    it 'shows an edit page' do
      get :edit, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_success
    end
  end

  context '#new' do
    it "shows a form for a new record" do
      get :new, diabetic_id: @chris.id
      expect(response).to be_success
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
      post :create, diabetic_id: @chris.id, record: {glucose: '115', weight: '174', taken_at: (Time.now-500), comment: "I just got created!"}
      expect(response).to be_redirect
    end

    it "renders the new record partial if a user inputs invalid params" do
      post :create, diabetic_id: @chris.id, record: {glucose:nil, weight: nil, taken_at: (Time.now() + (60*60*24))}
      expect(response).to_not be_redirect #this is a bad test
    end

  end


  context '#delete' do
    it 'should let a user delete a record' do
      delete :destroy, diabetic_id: @chris.id, id: @record1.id
      expect(response).to be_redirect
    end
  end
end
