class RecordsController < ApplicationController

  before_filter :redirect_if_logged_out, :load_diabetic
  before_filter :load_record, :except => [:index, :new, :create]

  def index
    respond_to do |format|
      format.html do
        render :partial => 'shared/records', locals: { records: @diabetic.records, diabetic: @diabetic }
      end
      format.pdf do
        @data = @diabetic.get_data_for_graph
        pdf = RecordDataPdf.new(@data, @diabetic)
        send_data pdf.render, filename: "#{@diabetic.name}_#{Time.now.strftime("%Y-%m-%d")}", type: "application/pdf"
      end
    end
  end

  def show
    render partial: "shared/record", locals: {record: @record, diabetic: @diabetic}
  end

  def new
    @record = Record.new
    render partial: 'shared/new_record', locals: {record: @record, diabetic: @diabetic}
  end

  def create
    @record = @diabetic.records.build(params[:record])
    unless @record.save
      flash[:notice] = "Please try again"
    end
    redirect_to :back
  end

  def edit
    render partial: 'shared/edit_record', locals: {record: @record, diabetic: @diabetic}
  end

  def update # Unused
    if @record.update_attributes(params[:record])
      path = diabetic_records_path(@diabetic)
      ok = true
    else
      path = edit_diabetic_record_path(@diabetic, @record)
    end
    render :json => {
                      ok: !!ok, # Saving kstrks
                      target: path,
                      alert: @record.errors.full_messages
                    }
  end

  def destroy
    @record.destroy
    redirect_to root_path
  end

  private

  def load_diabetic
    @diabetic = Diabetic.find(params[:diabetic_id])
  end

  def load_record
    @record = Record.find(params[:id])
  end

end
