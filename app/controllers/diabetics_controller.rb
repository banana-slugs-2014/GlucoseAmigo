class DiabeticsController < ApplicationController
  def new
    user = Account.last
    render :partial => "new", :locals => {  :diabetic => user.diabetics.new,
                                            :account => user }
  end

  def create
  end
end
