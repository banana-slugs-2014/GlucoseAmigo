module ApplicationHelper
  def current_account
    Account.find(session[:account_id])
  end

  def logged_in?
    !!session[:account_id]
  end

  def login account
    session[:account_id] = account.id
  end
end
