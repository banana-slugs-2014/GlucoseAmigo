class DoctorsController < ApplicationController

	def index
		#for testing
		#@doctor = Doctor.all.last
		#redirect_to new_doctor_path
	end

	def show
		@doctor = Doctor.find(params[:id])
		#render 
		#get
		#may not need this one; might always be edit
	end

	def new
		#redirect_to index_path
	end

	def create
		puts "========create, post=========="
		p params

		redirect_to doctors_path
		#post
	end

	def edit
		@doctor = Doctor.find(params[:id])
		#get
	end

	def update
		@doctor = Doctor.find(params[:id])
		@doctor
		puts "========update, put=========="
		p params

		redirect_to doctor_path(@doctor.id)
		#put
	end

	def destroy
		#delete
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