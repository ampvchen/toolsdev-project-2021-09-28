class Location < ApplicationRecord
  validates :location_id, uniqueness: true
end
