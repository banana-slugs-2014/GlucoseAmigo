require 'spec_helper'

describe RecordsController do

  context '#index' do
    it "is ok" do
      chris = Diabetic.create({name:'chris', email:'chris@dbc.com', age:'27'}, :without_protection => true)
      record1 = Record.create(glucose: '100', weight: '175')
      chris.records << record1
      get :index, diabetic_id: 1
      expect(response).to be_success
    end
  end

  context '#show' do
    xit { returns_valid_response }
  end
  context '#edit' do
    xit { returns_valid_response }
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
