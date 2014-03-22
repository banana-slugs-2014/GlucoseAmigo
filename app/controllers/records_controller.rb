class RecordsController < ApplicationController

  before_filter do
    @diabetic = Diabetic.find(params[:diabetic_id])
  end


  def index
    @records = @diabetic.records #take 10 at a time?
  end

  def show
    @record = Record.find(params[:id])
    render partial: "shared/record", locals: {record: @record, diabetic: @diabetic}
  end

  def new
    @record = Record.new
    #@diabetic = current_user #helper, to be written later
    render partial: 'shared/new_record', locals: {record: @record, diabetic: @diabetic}
  end

  def create
    @record = Record.create(params[:record])
    if @record.save
      @diabetic.records << @record
      redirect_to diabetic_record_path(@diabetic, @record)
    else
      flash[:notice] = "Please try again"
      render partial: 'shared/new_record', locals: {record: @record, diabetic: @diabetic}
    end
  end

  def edit
    @record = Record.find(params[:id])
    render partial: 'shared/edit_record', locals: {record: @record, diabetic: @diabetic}
  end

  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(params[:record])
      @record.save
      redirect_to diabetic_record_path(@diabetic, @record)
    else
      redirect_to edit_diabetic_record_path(@diabetic, @record)
    end #sad path

  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
    redirect_to diabetic_record_path(params[:diabetic_id])
  end

end
