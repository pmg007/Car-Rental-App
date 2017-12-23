class Suggestion < ApplicationRecord
#	validates :suggestion, presence:true
	validates :model, format: { with: /\A[a-zA-Z]+\z/, message: "allows only letters" }
	validates :manufacturer, format: { with: /\A[a-zA-Z]+\z/, message: "allows only letters" }
	validates :style, inclusion: { in: ['Hatchback', 'Sedan', 'SUV'], message: "Style is not Hatchback, Sedan or SUV" }
	validates :location ,presence: true
	belongs_to :user
end
