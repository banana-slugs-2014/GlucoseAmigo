class PreferencesController < ApplicationController

  def index
    #prly wont need
  end

  def create
    @diabetic = Diabetic.find(params[:diabetic_id])
    puts "============create=============="
    p @diabetic
    p params
    #@diabetic.preference = Preference
    #@diabetic.preference.
    #post
  end

  def new
    #@preference = Preference.new

  end

  def edit
    @preference = Preference.find(params[:id])
  end

  def show
  end

  def update
  end

  def destroy
  end

end

