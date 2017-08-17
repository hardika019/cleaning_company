class Booking < ActiveRecord::Base
  belongs_to :customer
  belongs_to :cleaner
  belongs_to :city

  validates :city_id, presence: true
	validates :date, presence: true
  validates :date, uniqueness: {scope: :city_id}
end
