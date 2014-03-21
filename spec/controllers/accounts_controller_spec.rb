require 'spec_helper'

describe AccountsController do
  let!(:account) { create :account }
  context "#index" do
    it "is sucessful" do
      get :index
      expect(response).to be_success
    end
  end

  context '#create' do
    it "creates with valid attributes" do
      expect {
        post :create, :account => {username: 'test1',
                                   email: 'test@test1.com',
                                   password: 'testing1',
                                   password_confirmation: 'testing1'}
      }.to change { Account.count }.by(1)
      response.should redirect_to accounts_path
    end

    it "doesn't create if attributes are invalid" do
      expect {
        post :create, :account => {}
      }.to_not change { Account.count }.by(1)
      response.should redirect_to new_account_path ### will redirect to diabetic dashboard

    end

  end

  context '#new' do
    it 'is sucessful' do
      expect(response).to be_success
    end

    it 'sets :account to new instance of Account' do
      get :new
      expect(assigns(:account)).to be_a_new Account
    end
  end

end
