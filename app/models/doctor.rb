class Doctor < ActiveRecord::Base
	validates_presence_of :name
	has_many :diabetics
end
