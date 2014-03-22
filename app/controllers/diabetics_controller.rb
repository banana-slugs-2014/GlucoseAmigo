class DiabeticsController < ApplicationController
  def new
    account = current_account
    render :partial => "shared/diabetic", :locals => {
                                            :diabetic => account.diabetics.new,
                                            :account => account }
  end

  def create
    diabetic = Diabetic.new(params[:diabetic])
    diabetic.account = current_account
    diabetic.birth_date = params[:birth_date]

    if diabetic.valid?
      diabetic.save
      redirect_to new_diabetic_doctor_path(diabetic_id: diabetic.id)
    else
      # change here too
      redirect_to new_account_diabetic_path(account_id: current_account.id)
    end
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
      diabetic.save
    end
    redirect_to edit_account_diabetic_path(account_id: current_account.id, id: diabetic.id)
  end

  def destroy
    Diabetic.find(params[:id]).destroy
    redirect_to new_account_diabetic_path(account_id: current_account.id)
  end
end
