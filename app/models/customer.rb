class Customer < ActiveRecord::Base
	has_many :bookings, dependent: :destroy
	has_many :cities, through: :bookings
	accepts_nested_attributes_for :bookings

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :phone_number, presence: true
end
