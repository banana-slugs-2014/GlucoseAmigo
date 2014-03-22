class SessionsController < ApplicationController

  def new
    @account = Account.new
    render :partial => 'shared/login', :locals => { :account => @account }
  end

  def create
    account = Account.find_by_username(params[:username]).try(:authenticate, params[:password])
    if account
      session[:user_id] = account.id
      redirect_to :back# diabetic dashboard
    else
      flash[:error] = 'Invalid Login information'
      redirect_to :back
    end
  end

  def destroy
    reset_session
    flash[:message] = 'You are logged out.'
    redirect_to root_path# home page
  end
end