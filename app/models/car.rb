class Car < ApplicationRecord
	validates :rate ,presence:true, numericality: {only_float: true}
	validates :model, format: { with: /\A[a-zA-Z]+\z/, message: "allows only letters" }
	validates :license, length: { is: 7 }, uniqueness: true
	validates :manufacturer, format: { with: /\A[a-zA-Z]+\z/, message: "allows only letters" }
	validates :style, inclusion: { in: ['Hatchback', 'Sedan', 'SUV'], message: "Style is not Hatchback, Sedan or SUV" }
	validates :status, inclusion: { in: ['RESERVED', 'CHECKEDOUT', 'AVAILABLE'], message: "Status is not CHECKEDOUT, RESERVED  or AVAILABLE" }
  validates :location ,presence: true
	has_many :reservations
	has_many :users, through: :reservations
	has_many :subscriptions
end
