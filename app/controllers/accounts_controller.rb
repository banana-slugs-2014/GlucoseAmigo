class AccountsController < ApplicationController
    before_filter :redirect_if_logged_in,  :only => [:new]
    before_filter :redirect_if_logged_out,  :except => [:new, :create, :index, :show]

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
    if logged_in? && current_account.id == params[:id].to_i
      @account = Account.find(params[:id])
      @diabetics = @account.diabetics
      @menu_options = ((@diabetics.map {|diabetic| "Diabetic: #{diabetic.name}--#{diabetic.id} "}) << "Account: #{@account.username}")
      render  'shared/dashboard',
              :locals => {
                account: @account,
                diabetics: @diabetics,
                menu_options: @menu_options
              }
    else
      redirect_to root_path
    end
  end

  def menu
    choices = params[:menu_choice].split(':')
    @account = Account.find(params[:account_id])
    case choices[0]
    when 'Diabetic'
      @diabetic = Diabetic.find(choices[1].split('--')[1])
      path = edit_account_diabetic_path(current_account, @diabetic)
    when 'Account'
      path = edit_account_path(current_account)
    end
    render :json => {
                      ok: true,
                      path: path,
                      alert: ''
                    }
  end

  def getSubmenu
    choices = params[:menu_choice].split(':')
    @account = current_account
    case choices[0]
    when 'Diabetic'
      @diabetic = Diabetic.find(choices[1].split('--')[1])
      edit_account_diabetic_path(current_account, @diabetic)
    when 'Account'
      path = edit_account_path(current_account)
    end
    render :partial => 'shared/menu', :locals => {
                                                    diabetic: @diabetic,
                                                    account: @account
                                                  }
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
      login account
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
      redirect_to accounts_path
    else
      flash[:error] = ['Invalid Password']
      redirect_to edit_account_path(account.id)
    end
  end

end
