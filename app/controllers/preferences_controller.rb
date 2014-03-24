class PreferencesController < ApplicationController

  def new
    @diabetic = Diabetic.find(params[:diabetic_id])
    #(redirect_to edit_diabetic_preference_path(@diabetic.id, @diabetic.preference)) if @diabetic.preference
    @preference = Preference.new
    render :partial => 'shared/new_preference', locals: {
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
    render :json {
        ok: true,
        path: diabetic_preference_path(@diabetic, @diabetic.preference),
        alert: preference.errors.full_message
      }
  end

  def show
    @diabetic = Diabetic.find(params[:diabetic_id])
    @preference = Preference.find(params[:id])
  end

  def edit
    @diabetic = Diabetic.find(params[:diabetic_id])
    @preference = Preference.find(params[:id])
  end

  def update
    @diabetic = Diabetic.find(params[:diabetic_id])
    if @diabetic.preference
      @diabetic.preference.update_attributes(params[:preference])
    else
      @diabetic.preference.create(params[:preference])
    end
    redirect_to diabetic_preference_path(@diabetic, @diabetic.preference)
  end

end
