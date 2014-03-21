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
		redirect_to doctor_path(@doctor.id) #"/doctors/#{@doctor.id}"
	end

	def edit
		@doctor = Doctor.find(params[:id])
	end

	def update
		@doctor = Doctor.find(params[:id])
		@doctor.update_attributes(params[:doctor])
		puts "========update, put=========="
		p params

		redirect_to doctor_path(@doctor.id)
	end

	def destroy
	end


end


# class CreateDoctors < ActiveRecord::Migration
#   def change
#     create_table :doctors do |t|
#       t.string :name
#       t.string :fax
#       t.text :comments
#       t.string :email
#     end
#   end
# end