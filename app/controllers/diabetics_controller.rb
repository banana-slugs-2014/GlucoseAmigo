class DiabeticsController < ApplicationController

  before_filter :redirect_if_logged_out

  def new
    account = current_account
    render :partial => "shared/diabetic", :locals => {
                                            :diabetic => account.diabetics.new,
                                            :account => account }
  end

  def create
    diabetic = Diabetic.new(params[:diabetic])
    diabetic.account = current_account
    if diabetic.valid?
      p "true man"
      ok = true
      diabetic.save
      DiabeticMailer.welcome_email(diabetic).deliver
      path = new_diabetic_doctor_path(diabetic_id: diabetic.id)
    else
      p "false"
      path = new_account_diabetic_path(account_id: current_account.id)
    end
    render :json => {
                      ok: !!ok, # Saving kstrks
                      target: path,
                      alert: diabetic.errors.full_messages
                    }
  end


  def edit
    diabetic = Diabetic.find(params[:id])
    render :partial => "shared/diabetic", :locals => {
                                                        diabetic: diabetic,
                                                        account: diabetic.account
                                                      }
  end

  def update
    diabetic = Diabetic.find(params[:id])
    diabetic.update_attributes(params[:diabetic])
    if diabetic.valid?
      ok = true
      diabetic.save
    end
    #redirect_to edit_account_diabetic_path(account_id: current_account.id, id: diabetic.id)
    render :json => {
                      ok: !!ok, # Saving kstrks
                      target: edit_account_diabetic_path(current_account, diabetic),
                      alert: diabetic.errors.full_messages
                    }
  end

  def destroy
    Diabetic.find(params[:id]).destroy
    redirect_to new_account_diabetic_path(account_id: current_account.id)
  end

  def get_graph_data
    @diabetic = Diabetic.find(params[:id])
    @data = diabetic.get_graph_data

  end


end
