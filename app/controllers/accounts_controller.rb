class AccountsController < ActionController::Base

  def index
    @account = Account.all
    render 'accounts/testing'
  end

  def new
    @account = Account.new
    render  :partial => 'shared/sign_up',
    :locals => {
      account: @account
    }
  end

  def create
    account = Account.create(params['account'])
    if account.errors.any?
      flash[:error] = account.errors.full_messages
       redirect_to new_account_path
     else
      redirect_to accounts_path
    end
  end

end
