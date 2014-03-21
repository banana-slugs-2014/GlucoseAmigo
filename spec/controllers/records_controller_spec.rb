require 'spec_helper'

describe RecordsController do

  context '#index' do
    it "is ok" do
      get :index, user_id: 1
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
