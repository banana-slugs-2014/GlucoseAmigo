class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  include DashboardHelper

  protected

  def redirect_if_logged_out
    redirect_to root_path unless logged_in?
  end

  def redirect_if_logged_in
    redirect_to root_path if logged_in?
  end
end
