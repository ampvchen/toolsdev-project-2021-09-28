class Location < ApplicationRecord
  validates :location_id, uniqueness: true
  validates :city, presence: true

  has_many :temperatures
end
