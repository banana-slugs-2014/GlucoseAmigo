class DoctorsController < ApplicationController

	before_filter :load_diabetic, :redirect_if_logged_out
	before_filter :load_doctor, :except => [:index, :new, :create,]

	def index
	end

	def show
	end

	def new
		@doctor = Doctor.new
		@title = "Create a doctor"
		render :partial => 'doctors/new', locals: {
																									diabetic: @diabetic,
																									doctor: @doctor,
																									title: 'Doctor Creation'
																								}
	end

	def create
		@doctor = Doctor.find_or_initialize_by_name_and_fax(params[:doctor])
		@diabetic.doctor = @doctor
		if @doctor.save
			ok = true
			path = new_diabetic_preference_path(diabetic_id: @diabetic.id)
		end
		render :json => {
											ok: !!ok, # Saving kstrks
											path: path,
											alert: @doctor.errors.full_messages
										}
	end

	def edit
		render :partial => 'doctors/edit', locals: {
																									diabetic: @diabetic,
																									doctor: @doctor,
																									title: 'Edit a doctor'
																								}
	end

	def update
		@doctor.update_attributes(params[:doctor])
		path = diabetic_doctor_path(@diabetic,@doctor) # to change to user path
		render :json => {
											ok: true, # Saving kstrks
											target: path,
											alert: @doctor.errors.full_messages
										}
	end

	def destroy
		render :json => {
											ok: !!ok, # Saving kstrks
											target: :back,
											alert: @doctor.errors.full_messages
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
