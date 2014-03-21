class DoctorsController < ApplicationController

	def show
		#get
		#may not need this one; might always be edit
	end

	def create
		#post
	end

	def edit
		#get
	end

	def update
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