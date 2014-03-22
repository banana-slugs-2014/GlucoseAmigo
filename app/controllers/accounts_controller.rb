class AccountsController < ApplicationController
    before_filter :redirect_if_logged_in,  :only => [:new]
    before_filter :redirect_if_logged_out,  :except => [:new]

  def show
    @account = Account.find(params[:id])
    @diabetics = @account.diabetics
    @menu_options = ((@diabetics.map {|diabetic| "Diabetic: #{diabetic.name}--#{diabetic.id} "}) << "Account: #{@account.username}")
  end

  def menu
    choices = params[:menu_choice].split(':')
    @account = Account.find(params[:account_id])
    case choices[0]
    when 'Diabetic'
      @diabetic = Diabetic.find(choices[1].split('--')[1])
      render partial: 'shared/diabetic', locals: {account: @account, diabetic: @diabetic}  #one day this will go somewhere real.
    when 'Account'
      render partial: 'shared/edit_account', locals: {account: @account}  #works, but is stupid.
    end
  end

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
    if account.errors.any?
      flash[:error] = account.errors.full_messages
      redirect_to new_account_path
    else
      session[:user_id] = account.id
      redirect_to new_account_diabetic_path(account.id)
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
