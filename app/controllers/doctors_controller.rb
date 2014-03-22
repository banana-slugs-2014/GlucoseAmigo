class DoctorsController < ApplicationController
	before_filter :load_diabetic
	before_filter :load_doctor, :except => [:index, :new, :create,]
	def index
	end

	def show
	end

	def new
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.find_or_create_by_name_and_fax(params[:doctor])
		if @doctor.valid?
			@doctor.diabetics << @diabetic
			redirect_to diabetic_doctor_path(diabetic_id: @diabetic.id, id: @doctor.id)
		else
			redirect_to diabetic_doctors_path(diabetic_id: @diabetic.id)
		end
	end

	def edit
	end

	def update
		@doctor.update_attributes(params[:doctor])
		redirect_to diabetic_doctor_path(diabetic_id: @diabetic.id, id: @doctor.id) # to change to user path
	end

	def destroy
	end

	private

	def load_diabetic
		@diabetic = Diabetic.find(params[:diabetic_id])
	end

	def load_doctor
		@doctor = Doctor.find(params[:id])
	end
end
