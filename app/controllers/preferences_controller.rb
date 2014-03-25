class PreferencesController < ApplicationController

  def new
    # move this to a before_filter
    @diabetic = Diabetic.find(params[:diabetic_id])
    #(redirect_to edit_diabetic_preference_path(@diabetic.id, @diabetic.preference)) if @diabetic.preference
    @preference = Preference.new
    render :partial => 'shared/new_preference', locals: {
                                                          title: "Create a doctor",
                                                          diabetic: @diabetic,
                                                          preference: @preference
                                                        }
  end

  def create
    @diabetic = Diabetic.find(params[:diabetic_id])
    if @diabetic.preference
      @diabetic.preference.update_attributes(params[:preference])
    else
      preference = Preference.create(params[:preference])
      @diabetic.preference = preference
    end
    redirect_to account_path(current_account)
    # render :json => {
    #     ok: true,
    #     path: diabetic_preference_path(@diabetic),
    #     alert: @diabetic.preference.errors.full_message
    #   }
  end

  def show
    @diabetic = Diabetic.find(params[:diabetic_id])
    @preference = Preference.find(params[:id])
    render :partial => 'shared/show_preference', locals: {
                          diabetic: @diabetic,
                          preference: @preference
                        }
  end

  def edit
    @diabetic = Diabetic.find(params[:diabetic_id])
    @preference = Preference.find(params[:id])
    render :partial => 'shared/new_preference', locals: {
                                                          title: "Modify a doctor",
                                                          diabetic: @diabetic,
                                                          preference: @preference
                                                        }
  end

  def update
    @diabetic = Diabetic.find(params[:diabetic_id])
    if @diabetic.preference
      @diabetic.preference.update_attributes(params[:preference])
    else
      @diabetic.preference.create(params[:preference])
    end
    render :json => {
        ok: true,
        path: diabetic_preference_path(@diabetic, @diabetic.preference),
        alert: @diabetic.preference.errors.full_message
      }
  end

end
