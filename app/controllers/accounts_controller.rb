class AccountsController < ActionController::Base

  def index
    @account = Account.all
    render 'accounts/testing'
  end

  def new
    render  :partial => 'shared/sign_up',
    :locals => {
      account: Account.new
    }
  end

  def create
    account = Account.create(params['account'])
    puts account.errors.any?
    redirect_to accounts_path
  end

end
