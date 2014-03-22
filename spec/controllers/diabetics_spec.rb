require 'spec_helper'

describe DiabeticsController do
  before(:each) do
    @account = Account.create(username: 'tester', email: 'test@test.com', password: 'password', password_confirmation: 'password')
  end

  let(:valid_params) { attributes_for :diabetic }
  let(:birth_date) do
    {
      year: Date.today.year - rand(5),
      month: Date.today.month,
      day: Date.today.day
    }
  end

  context 'with valid params' do
    it 'should add a diabetic when adding on the correct path' do
      params = { diabetic: valid_params,
                 birth_date: birth_date,
                 account_id: @account.id }

      expect{
        post :create, params
        expect(response).to be_redirect
      }.to change {Diabetic.count}.by 1
    end
  end

  context 'with invalid params' do
    it 'should not add a diabetic when adding on the correct path' do
      params = {
              diabetic: {},
              birth_date: birth_date,
              account_id: @account.id
      }

      expect{
        post :create, params

        expect(response).to be_redirect
      }.to_not change(Diabetic, :count)
    end
  end
end
