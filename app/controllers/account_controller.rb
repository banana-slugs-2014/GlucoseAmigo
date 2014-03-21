class AccountController < ActionController::Base

  def new
    render  :partial => 'shared/sign_up',
    :locals => {
      account: Account.new
    }
  end

  def create
    account = Account.new(params[:account])
  end
end
