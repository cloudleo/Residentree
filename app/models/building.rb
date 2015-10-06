class Building < ActiveRecord::Base
	validates :address, :presence => {:message => "Please enter an address."}

end
