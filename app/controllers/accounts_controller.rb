class AccountsController < ActionController::Base

  def index
    @account = Account.all
    render 'accounts/testing'
  end

  def new
     # @account = Account.new
    render  :partial => 'shared/sign_up',
    :locals => {
      account: Account.new
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

  def edit
    @account = Account.find(params[:id])
    render :partial => 'shared/edit_account',
    :locals => {
      account: @account
    }
  end

  def change_password
    account = Account.find(params['account']['id'])
    if account.authorized?(params) && account.confirmed?(params)
      account.password = params['account']['new_password']
      if account.save
        redirect_to accounts_path
      else
        flash[:error] = account.errors.full_messages
        redirect_to edit_account_path(account.id)
      end
    else
      account.confirmed?(params) ? (flash[:error] = ['Invalid Password']) :
                                   (flash[:error] = ["Password must doesn't match confirm"])
      redirect_to edit_account_path(account.id)
    end
  end

  def update
    account = Account.find(params['id'])
    if  account.authorized?(params)
      account.update_attributes(params[:account])
      redirect_to accounts_path
    else
      flash[:error] = ['Invalid Password']
      redirect_to edit_account_path(account.id)
    end
  end



end
