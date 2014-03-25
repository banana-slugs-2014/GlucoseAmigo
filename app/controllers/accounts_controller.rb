class AccountsController < ApplicationController
    before_filter :redirect_if_logged_in,  :only => [:new]
    before_filter :redirect_if_logged_out,  :except => [:new, :create, :index]
    before_filter :redirect_unless_authorized, :only => [:show, :menu]

  def index
  end

  def test
    render  :partial => 'shared/sign_up',
            :locals => {
              account: Account.new
            }
  end

  def show
    @diabetics = current_account.diabetics
    @menu_options = ((@diabetics.map {|diabetic| "Diabetic: #{diabetic.name}--#{diabetic.id} "}) << "Account: #{current_account.username}")
    render  'shared/dashboard',
            :locals => {
              account: current_account,
              diabetics: @diabetics,
              menu_options: @menu_options
            }
  end

  def menu
    choices = params[:menu_choice].split(':')
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
    case choices[0]
    when 'Diabetic'
      @diabetic = Diabetic.find(choices[1].split('--')[1])
      edit_account_diabetic_path(current_account, @diabetic)
    when 'Account'
      path = edit_account_path(current_account)
    end
    render :partial => 'shared/menu', :locals => {
                                                    diabetic: @diabetic,
                                                    account: current_account
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
    render  :partial => 'shared/edit_account',
            :locals => {
              account: current_account
            }
  end

  def change_password
    if current_account.authenticate(params[:account][:password])#.authorized?(params) && current_account.confirmed?(params)
      current_account.password = params['account']['new_password']
      if current_account.save
        ok = true
        path = account_path(current_account)
      else
        path = edit_account_path(current_account)
      end
    else
      account.confirmed?(params) ? (flash[:error] = ['Invalid Password']) :
                                   (flash[:error] = ["Password must doesn't match confirm"]) # To check
      path = edit_account_path(current_account)
    end
    render :json => {
                      ok: !!ok,
                      path: path,
                      alert: current_account.errors.full_messages
                    }
  end

  def update
    if  current_account.authorized?(params)
      ok = true
      current_account.update_attributes(params[:account])
      redirect_to accounts_path
    else
      flash[:error] = ['Invalid Password']
      redirect_to edit_account_path(current_account)
    end
  end

  private

  def redirect_unless_authorized
    redirect_to root_path unless current_account.id == params[:id].to_i
  end
end
