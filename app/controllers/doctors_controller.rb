class DoctorsController < ApplicationController

	before_filter :load_diabetic
	before_filter :load_doctor, :except => [:index, :new, :create,]
  before_filter :redirect_if_logged_out

	def index
	end

	def show
	end

	def new
		@doctor = Doctor.new
		render :partial => 'shared/doctor', locals: {
																									diabetic: @diabetic,
																									doctor: @doctor,
																									title: 'Doctor Creation'
																								}
	end

	def create
		@doctor = Doctor.find_or_create_by_name_and_fax(params[:doctor])
		if @doctor.valid?
			ok = true
			@doctor.diabetics << @diabetic
			path = diabetic_doctor_path(diabetic_id: @diabetic.id, id: @doctor.id)
		else
			path = diabetic_doctors_path(diabetic_id: @diabetic.id)
		end
		render :json => {
											ok: !!ok, # Saving kstrks
											target: path,
											alert: doctor.errors.full_messages
										}
	end

	def edit
		render :partial => 'shared/doctor', locals: {
																									diabetic: @diabetic,
																									doctor: @doctor,
																									title: 'Edit a doctor'
																								}
	end

	def update
		@doctor.update_attributes(params[:doctor])
		path = diabetic_doctor_path(diabetic_id: @diabetic.id, id: @doctor.id) # to change to user path
		render :json => {
											ok: !!ok, # Saving kstrks
											target: path,
											alert: doctor.errors.full_messages
										}
	end

	def destroy
		render :json => {
											ok: !!ok, # Saving kstrks
											target: :back,
											alert: doctor.errors.full_messages
										}
	end

	private

	def load_diabetic
		@diabetic = Diabetic.find(params[:diabetic_id])
	end

	def load_doctor
		@doctor = Doctor.find(params[:id])
	end
end
