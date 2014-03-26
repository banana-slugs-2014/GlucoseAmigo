class DiabeticsController < ApplicationController

  before_filter :redirect_if_logged_out, except: [ :new ]
  before_filter :load_diabetic, except: [ :create, :new ]

  def new
    account = current_account
    render :partial => "diabetics/new", :locals => {
      :diabetic => account.diabetics.new,
    :account => account }
  end

  def create
    diabetic = current_account.diabetics.build(params[:diabetic])
    if diabetic.save
      ok = true
      DiabeticMailer.welcome_email(diabetic).deliver
      path = new_diabetic_doctor_path(diabetic_id: diabetic.id)
    else
      path = new_account_diabetic_path(account_id: current_account.id)
    end
    render :json => {
      ok: !!ok, # Saving kstrks
      path: path,
      alert: diabetic.errors.full_messages
    }
  end

  def edit
    render :partial => "diabetics/edit", :locals => {
      diabetic: @diabetic,
      account: @diabetic.account
    }
  end

  def update
    @diabetic.update_attributes(params[:diabetic])
    if @diabetic.save
      ok = true
      path = dashboard_path
    end
    render :json => {
                      ok: !!ok,
                      path: path,
                      alert: @diabetic.errors.full_messages
                    }
  end

  def destroy
    @diabetic.destroy
    render :json => {
                      ok: true,
                      path: dashboard_path,
                      alert: 'User has been deleted'
                    }
  end





  private
  def load_diabetic
    @diabetic = Diabetic.find(params[:id])
  end

end
