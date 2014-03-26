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
      ok = true
      login account
      path = account_path(account)
    else
      alert = 'invalid login information'
      path = root_path
    end
    render :json => {
                      ok: !!ok,
                      path: path,
                      alert: alert
                    }
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
