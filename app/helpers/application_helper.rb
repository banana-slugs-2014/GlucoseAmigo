module ApplicationHelper
  def current_account
    Account.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end


end
