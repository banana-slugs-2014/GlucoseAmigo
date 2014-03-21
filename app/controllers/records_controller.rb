class RecordsController < ApplicationController

  def index
    @records = Record.all
  end

  def show
    @record = Record.find(params[:id])
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.create(params[:record])
    if @record.save
      current_user.records << @record
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
