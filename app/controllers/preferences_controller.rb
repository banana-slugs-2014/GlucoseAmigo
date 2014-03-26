class PreferencesController < ApplicationController
  before_filter :load_diabetic
  before_filter :load_preference, :except => [ :new ]

  def new
    @preference = Preference.new
    render :partial => 'preferences/new', locals: {
                                                          diabetic: @diabetic,
                                                          preference: @preference
                                                        }
  end

  def create
    if @preference
      @preference.update_attributes(params[:preference])
    else
      @diabetic.preference = Preference.create(params[:preference])
    end
    render :json => {
                      ok: !!ok, # Saving kstrks
                      path: dashboard_path,
                      alert: @doctor.errors.full_messages
                    }
  end

  def show
    render :partial => 'preferences/show', locals: {
                          diabetic: @diabetic,
                          preference: @preference
                        }
  end

  def edit
    render :partial => 'preferences/edit', locals: {
                                                          title: "Modify a doctor",
                                                          diabetic: @diabetic,
                                                          preference: @preference
                                                        }
  end

  def update
    if @preference.update_attributes(params[:preference])
      ok = true
      path = dashboard_path
    end
    render :json => {
        ok: !!ok,
        path: path,
        alert: @preference.errors.full_messages
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
