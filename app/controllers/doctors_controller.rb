class DoctorsController < ApplicationController

	def index
	end

	def show
		@doctor = Doctor.find(params[:id])
	end

	def new
	end

	def create
		@doctor = Doctor.find_or_create_by_name_and_fax(params[:doctor])
		redirect_to doctor_path(@doctor.id)
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