class AccountsController < ApplicationController
    before_filter :redirect_if_logged_in,  :only => [:new]
    before_filter :redirect_if_logged_out,  :except => [:new, :create, :index]

  def index
    redirect_to account_path(current_account) if logged_in?
  end

  def test
    render  :partial => 'shared/sign_up',
            :locals => {
              account: Account.new
            }
  end

  def show
    redirect_to :back unless current_account.id == params[:id].to_i
    @account = Account.find(params[:id])
    @diabetics = @account.diabetics
    @menu_options = ((@diabetics.map {|diabetic| "Diabetic: #{diabetic.name}--#{diabetic.id} "}) << "Account: #{@account.username}")
    render  'shared/dashboard',
            :locals => {
              account: @account,
              diabetics: @diabetics,
              menu_options: @menu_options
            }
  end

  def menu
    choices = params[:menu_choice].split(':')
    @account = Account.find(params[:account_id])
    case choices[0]
    when 'Diabetic'
      @diabetic = Diabetic.find(choices[1].split('--')[1])
      render partial: 'shared/edit_diabetic', locals: {account: @account, diabetic: @diabetic}  #one day this will go somewhere real.
    when 'Account'
      render partial: 'shared/edit_account', locals: {account: @account}  #works, but is stupid.
    end
  end

  def new
    render  :partial => 'shared/sign_up',
    :locals => {
      account: Account.new
    }
  end

  def create
    account = Account.create(params['account'])
    if account.valid?
      ok = true
      session[:user_id] = account.id
      path = new_account_diabetic_path(account.id)
    else
      path = new_account_path
    end
    render :json => {
                      ok: !!ok,
                      path: path,
                      alert: account.errors.full_messages
                    }
  end

  def edit
    @account = Account.find(params[:id])
    render  :partial => 'shared/edit_account',
            :locals => {
              account: @account
            }
  end

  def change_password
    account = Account.find(params['account']['id'])
    if account.authorized?(params) && account.confirmed?(params)
      account.password = params['account']['new_password']
      if account.save
        ok = true
        path = account_path(account.id)
      else
        path = edit_account_path(account.id)
      end
    else
      account.confirmed?(params) ? (flash[:error] = ['Invalid Password']) :
                                   (flash[:error] = ["Password must doesn't match confirm"]) # To check
      path = edit_account_path(account.id)
    end
    render :json => {
                      ok: !!ok,
                      path: path,
                      alert: account.errors.full_messages
                    }
  end

  def update
    account = Account.find(params['id'])
    if  account.authorized?(params)
      ok = true
      account.update_attributes(params[:account])
      path = accounts_path
    else
      flash[:error] = ['Invalid Password']
      path = edit_account_path(account.id)
    end
    render :json => {
                      ok: !!ok,
                      path: path,
                      alert: account.errors.full_messages
                    }
  end

end
