class PreferencesController < ApplicationController
  before_filter :load_diabetic
  before_filter :load_preference, :except => [ :new ]

  def new
    @preference = Preference.new
    render :partial => 'shared/new_preference', locals: {
                                                          title: "Create a doctor",
                                                          diabetic: @diabetic,
                                                          preference: @preference
                                                        }
  end

  def create
    if @preference
      @preference.update_attributes(params[:preference])
    else
      @diabetic.preference = Preference.create(params[:preference]) # Default values and select boxes prevent from being bad.
    end
    redirect_to account_path(current_account)
  end

  def show
    render :partial => 'shared/show_preference', locals: {
                          diabetic: @diabetic,
                          preference: @preference
                        }
  end

  def edit
    render :partial => 'shared/new_preference', locals: {
                                                          title: "Modify a doctor",
                                                          diabetic: @diabetic,
                                                          preference: @preference
                                                        }
  end

  def update
    @preference.update_attributes(params[:preference])
    render :json => {
        ok: true,
        path: diabetic_preference_path(@diabetic, @diabetic.preference),
        alert: @diabetic.preference.errors.full_message
      }
  end

  private

  def load_diabetic
    @diabetic = Diabetic.find(params[:diabetic_id])
  end

  def load_preference
    @preference = @diabetic.preference
  end

end
