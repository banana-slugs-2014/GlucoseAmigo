module AuthenticationHelper
  def current_account
    @account ||= Account.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_account
  end

  def login account
    # I woul rename this key to account_id
    session[:user_id] = account.id
  end
end
