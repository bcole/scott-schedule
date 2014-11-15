class Block < ActiveRecord::Base
	#has_and_belongs_to_many :volunteers

	has_many :confirmations
	has_many :volunteers, :through => :confirmations
end
