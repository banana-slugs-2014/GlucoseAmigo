require 'spec_helper'

describe DiabeticsController do
  before(:each) do
    @account = Account.create(username: 'tester', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    @diabetic = Diabetic.create(name: 'Glen', email: 'test@test.com', birth_date: birth_date)
    request.session[:user_id] = @account.id
  end

  let(:valid_params) do
    {
      diabetic: attributes_for(:diabetic),
      birth_date: birth_date,
      account_id: @account.id
    }
  end

  let(:invalid_params) do
    {
      diabetic: {},
      birth_date: birth_date,
      account_id: @account.id
    }
  end

  let(:birth_date) do
  {
      year: (Date.today.year - 10 - rand(5)),
      month: Date.today.month,
      day: Date.today.day
  }

  end
  describe '#create' do
    context 'with valid params' do
      it 'should add a diabetic when adding on the correct path' do
        expect{
          post :create, valid_params
          expect(response).to be_redirect
        }.to change {Diabetic.count}.by 1
      end
    end

    context 'with invalid params' do
      it 'should not add a diabetic when adding on the correct path' do
        expect{
          post :create, invalid_params
          expect(response).to be_redirect
        }.to_not change(Diabetic, :count)
      end
    end
  end


describe '#edit' do
  it 'should have an edit page' do
    get :edit, id: @diabetic.id, account_id: @account.id
    expect(response).to be_ok
  end
end

describe '#update' do

    let(:valid_edit_params) do
      {
      diabetic: attributes_for(:diabetic),
      birth_date: birth_date,
      id: @diabetic.id,
      account_id: @account.id
      }
    end

    let(:invalid_edit_params) do
      {
      diabetic: {},
      birth_date: birth_date,
      id: @diabetic.id,
      account_id: @account.id
      }
    end

    context 'with valid parameters' do
      it 'should edit a Diabetic' do
        expect {
          put :update, valid_edit_params
          expect(response).to be_redirect
        }.to change { Diabetic.find(@diabetic.id).name }
      end
    end

    context 'with invalid parameters' do
      it 'should not edit a Diabetic' do
        expect {
          put :update, invalid_edit_params
          expect(response).to be_redirect
        }.to_not change { Diabetic.find(@diabetic.id).name }
      end
    end
  end
end
