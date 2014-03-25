class DashboardController < ApplicationController
  def get
    choices = params[:menu_choice].split(':')
    @diabetic = Diabetic.find(choices[1].split('--')[1]) if choices[0] == 'Diabetic'
    render :partial => 'shared/menu', :locals => {
                                                    diabetic: @diabetic,
                                                    account: current_account
                                                  }
  end
end
