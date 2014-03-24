class SessionsController < ApplicationController

  before_filter :redirect_if_logged_in,  :only => [:new]
  before_filter :redirect_if_logged_out,  :only => [:destroy]

  def new
    @account = Account.new
    render :partial => 'shared/login', :locals => { :account => @account }
  end

  def create
    account = Account.find_by_username(params[:username]).try(:authenticate, params[:password])
    if account
      session[:user_id] = account.id
      redirect_to account_path(account)
    else
      render :json => {
                        ok: false,
                        alert: 'Invalid Login information'
                      }
    end
  end

  def destroy
    reset_session
    redirect_to root_path
    # render :json => {
    #                   ok: true,
    #                   alert: 'You are logged out.',
    #                   target: '/'
    #                 }
  end
end
