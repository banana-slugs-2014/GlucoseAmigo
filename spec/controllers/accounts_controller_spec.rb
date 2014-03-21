require 'spec_helper'

describe UsersController do
  let!(:user) { User.create(username: 'test',
                            email: 'test@test.com',
                            password: 'testing',
                            password_confirmation: 'testing')}
  context "#index" do
    xit "is sucessful" do
      get :index
      expect(response).to be_success
    end

    xit 'redirects if logged_in' do
      session[:id] = user.id
      get :index
      expect(response).to be_redirect
    end

   context '#create' do
    xit "creates with valid attributes" do
      expect {
        post :create, :user => {username: 'test1',
                            email: 'test@test1.com',
                            password: 'testing1',
                            password_confirmation: 'testing1'}
      }.to change { User.count }.by(1)
      response.should redirect_to '/'
    end

    xit "doesn't create if attributes are invalid" do
      expect {
        post :create, :user => {}
      }.to_not change { User.count }.by(1)
    response.should redirect_to '/users/new'
    end

  end

    context '#show' do
      xit 'sets @user to current user' do
        session[:id] = user.id
        get :show, :id => user.id
        expect(assigns(:user)).to eq(User.find(session[:id]))
      end
     end

   context '#new' do
    xit 'sets @user to new instance of User' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
   end

end


end