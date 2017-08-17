class Cleaner < ActiveRecord::Base
	has_and_belongs_to_many :cities

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :quality_score, presence: true, :inclusion => { :in => 0.0..5.0 }
end
