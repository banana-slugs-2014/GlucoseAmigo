class RecordsController < ApplicationController
  before_filter :redirect_if_logged_out, :load_diabetic

  def index
    @records = @diabetic.records
    @data = @diabetic.get_data_for_graph
    respond_to do |format|
      format.html
      format.pdf do
        pdf = RecordDataPdf.new(@data, @diabetic)
        send_data pdf.render, filename: "#{@diabetic.name}_#{Time.now.strftime("%Y-%m-%d")}", type: "application/pdf"
      end
    end
  end

  def show
    @record = Record.find(params[:id])
    # why is record and new_record in shared folder? and why are they called that?
    render partial: "shared/record", locals: {record: @record, diabetic: @diabetic}
  end

  def new
    @record = Record.new
    #@diabetic = current_user #helper, to be written later
    render partial: 'shared/new_record', locals: {record: @record, diabetic: @diabetic}
  end

  def create
    @record  = @diabetic.records.build params[:record]
    if @record.save
      redirect_to diabetic_records_path(@diabetic)
    else
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
      redirect_to diabetic_records_path(@diabetic)
    else
      redirect_to edit_diabetic_record_path(@diabetic, @record)
    end

  end

  def destroy
    # this is repeated code, move it to a filter
    record = Record.find(params[:id])
    record.destroy
    redirect_to diabetic_record_path(params[:diabetic_id])
  end

  private
  def load_diabetic
    @diabetic = Diabetic.find(params[:diabetic_id])
  end
end
