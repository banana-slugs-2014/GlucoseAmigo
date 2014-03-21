class DiabeticsController < ApplicationController
  def new
    # to change to current_user
    user = Account.last
    # user = current_user
    render :partial => "new", :locals => {  :diabetic => user.diabetics.new,
                                            :account => user }
  end

  def create
    diabetic = Diabetic.new(params[:diabetic])
    #diabetic.account = current_user
    diabetic.birth_date = params[:birth_date]
    if diabetic.valid?
      diabetic.save
      redirect_to new_account_diabetic_path(account_id: Account.last.id)
      #redirect_to account_path(account_id: diabetic.account.id)
    else
      # change here too
      redirect_to new_account_diabetic_path(account_id: Account.last.id)
    end
  end

  def build_date(birth_date)
    Date.parse(birth_date.values.join('-'))
  end
end
