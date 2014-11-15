class Confirmation < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :block
end
