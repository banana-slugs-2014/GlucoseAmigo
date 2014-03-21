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
      render partial: 'shared/record' locals {record: @record}
    else

  end

  def edit
    @record = Record.find(params[:id])




  end

  def update
    @record = Record.find(params[:id])
    @record.update_attributes(params)
  end

  def delete
  end

end
