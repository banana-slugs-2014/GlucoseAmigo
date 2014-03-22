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
      expect(response).to render_template(:partial => 'shared/sign_up',
                                          :locals => {:account => Account.new})
    end
  end

  context 'edit' do
    it 'is sucessful' do
      expect(response).to be_success
    end

    it 'sets @account to Account to be edited' do
      get :edit, id: account.id
      expect(assigns(:account)).to eq(Account.find(account.id))
    end
  end


  context 'update' do
    it 'updates username if password is correct' do
    put :update, id: account.id, 'account' => {'username' => 'test1',
                                   'email' => 'test@test1.com',
                                   'password' => 'testing',
                                   'password_confirmation' => 'testing'}
    expect{
      account.reload.username}.to change{account.username}.to "test1"
    end
    it 'updates email if password is correct' do
    put :update, id: account.id, 'account' => {'username' => 'test1',
                                   'email' => 'test@test1.com',
                                   'password' => 'testing',
                                   'password_confirmation' => 'testing'}
    expect{
      account.reload.email}.to change{account.email}.to "test@test1.com"
      response.should redirect_to accounts_path
    end

    it "doesn't update email if password is correct" do
    put :update, id: account.id, 'account' => {'username' => 'test1',
                                   'email' => 'test@test1.com',
                                   'password' => 'testing1',
                                   'password_confirmation' => 'testing1'}
    expect{
      account.reload.email}.to_not change{account.email}.to "test@test1.com"
      response.should redirect_to edit_account_path(account.id)
    end
  end

  context 'change password' do
    it 'update new password if password is authorized and confirmed' do

    expect{
      put :change_password,  'account' => {
                                    'id' => account.id,
                                   'new_password' => 'newpassword',
                                   'password_confirmation' => 'newpassword',
                                    'password' => 'testing'}
      }.to change{ Account.find(account.id).authenticate('testing') }.to false
      response.should redirect_to accounts_path
    end
  end

  context 'change password' do
    it 'does not update new password if password is not authorized and confirmed' do

    expect{
      put :change_password,  'account' => {
                                    'id' => account.id,
                                   'new_password' => 'newpassword',
                                   'password_confirmation' => 'newpassword',
                                    'password' => 'testing1'}
      }.to_not change{ Account.find(account.id).authenticate('testing') }.to false
      response.should redirect_to edit_account_path(account.id)
    end
  end

end


