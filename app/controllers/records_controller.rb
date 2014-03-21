class RecordsController < ApplicationController

  def index
<<<<<<< HEAD
    @diabetic = params[:diabetic_id]
    @records = @diabetic.records #take 10 at a time?
=======
    @records = Record.all
>>>>>>> 1d77a2dbbcb3ebd063e7fa2b48dd8a5a642a4056
  end

  def show
    @record = Record.find(params[:id])
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.create(params[:record])
<<<<<<< HEAD
    @diabetic = Diabetic.find(params[:diabetic_id])
    if @record.save
      @diabetic.records << @record
=======
    if @record.save
      current_user.records << @record
>>>>>>> 1d77a2dbbcb3ebd063e7fa2b48dd8a5a642a4056
      #render partial: 'shared/record' locals {record: @record}
    else
      #render partial :edit
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    redirect_to record_path(@record) and return if @record.update_attributes(params[:record])
    redirect_to edit_record_path(@record) #sad path
    #render partial: 'shared/record' locals {record: @record}
  end

  def delete
    record = Record.find(params[:id])
    record.destroy
    redirect_to root_path
  end

end
