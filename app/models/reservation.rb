class Reservation < ApplicationRecord
	validates :hours,presence:true


	belongs_to :user
	belongs_to :car
end
