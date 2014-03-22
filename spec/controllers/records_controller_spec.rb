require 'spec_helper'

describe RecordsController do
  before :each do
      @chris = Diabetic.create({name:'chris', email:'chris@dbc.com', age:'27'}, :without_protection => true)
      @record1 = Record.create(glucose: '100', weight: '175', taken_at: (Time.now-500))
      @chris.records << @record1
    end


  context '#index' do
    it "gets a users records" do
      get :index, diabetic_id: 1
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
    get :edit, diabetic_id: @chris.id, id: @record1.id
    expect(response).to be_success

  end
  context '#new' do
    xit { returns_valid_response }
  end
  context '#update' do
    xit { returns_valid_response }
  end
  context '#create' do
    xit { returns_valid_response }
  end
  context '#delete' do
    xit { returns_valid_response }
  end



end
