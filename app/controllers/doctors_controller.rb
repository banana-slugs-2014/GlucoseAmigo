class DoctorsController < ApplicationController

	def index
	end

	def show
		@doctor = Doctor.find(params[:id])
	end

	def new
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.find_or_create_by_name_and_fax(params[:doctor])
		if @doctor.id
			redirect_to doctor_path(@doctor.id) 
		else
			redirect_to doctors_path
		end
	end

	def edit
		@doctor = Doctor.find(params[:id])
	end

	def update
		@doctor = Doctor.find(params[:id])
		@doctor.update_attributes(params[:doctor])
		redirect_to doctor_path(@doctor.id)
	end

	def destroy
	end


end