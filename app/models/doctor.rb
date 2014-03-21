class Doctor < ActiveRecord::Base
	validates_presence_of :name
	has_many :diabetics
	attr_accessible :name, :fax, :email, :comments
end
