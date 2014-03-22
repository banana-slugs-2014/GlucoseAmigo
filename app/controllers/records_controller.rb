class RecordsController < ApplicationController

  def index
    @diabetic = Diabetic.find(params[:diabetic_id])
    @records = @diabetic.records #take 10 at a time?
  end

  def show
    @diabetic = Diabetic.find(params[:diabetic_id])
    @record = Record.find(params[:id])
    render partial: "shared/record", locals: {record: @record, diabetic: @diabetic}
  end

  def new
    @record = Record.new
    @diabetic = Diabetic.find(params[:diabetic_id])
    #@diabetic = current_user #helper, to be written later
    render partial: 'shared/new_record', locals: {record: @record, diabetic: @diabetic}
  end

  def create
    @record = Record.create(params[:record])
    @diabetic = Diabetic.find(params[:diabetic_id])
    if @record.save
      @diabetic.records << @record
      redirect_to diabetic_record_path(@diabetic, @record)
    else

    end
  end

  def edit
    @record = Record.find(params[:id])
    @diabetic = Diabetic.find(params[:diabetic_id])
    render partial: 'shared/edit_record', locals: {record: @record, diabetic: @diabetic}
  end

  def update
    @record = Record.find(params[:id])
    if @record.update_attributes(params[:record])
      @record.save
      redirect_to diabetic_record_path(@record)
    else
      redirect_to edit_diabetic_record_path(@record)
    end #sad path

  end

  def destroy
    record = Record.find(params[:id])
    record.destroy
    redirect_to diabetic_record_path(params[:diabetic_id])
  end

end
