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
      p @record1
      put :update, diabetic_id: @chris.id, id: @record1.id, record: {glucose: '120', weight: '176', taken_at: Time.now-500, comment: "I just got updated!"}
      expect(response).to be_redirect
      p @record1
    end
  end
  context '#create' do
    xit { returns_valid_response }
  end
  context '#delete' do
    xit { returns_valid_response }
  end



end
