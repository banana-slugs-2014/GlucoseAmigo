class SessionsController < ApplicationController

  before_filter :redirect_if_logged_in,  :only => [:new]
  before_filter :redirect_if_logged_out,  :only => [:destroy]

  def new
    @account = Account.new
    render :partial => 'sessions/new', :locals => { :account => @account }
  end

  def create
    account = Account.find_by_username(params[:username]).try(:authenticate, params[:password])
    if account
      login account
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
    render :json => {
                      ok: true,
                      path: root_path,
                      alert: 'You have been logged out'
                     }
  end
end
