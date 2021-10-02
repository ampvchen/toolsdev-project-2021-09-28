class Location < ApplicationRecord
  validates :location_id, uniqueness: true
  has_many :temperatures
end
