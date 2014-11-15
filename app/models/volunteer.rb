class Volunteer < ActiveRecord::Base
	#has_and_belongs_to_many :blocks

	has_many :confirmations
	has_many :blocks, :through => :confirmations
end
