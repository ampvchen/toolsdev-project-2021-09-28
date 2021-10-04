class Location < ApplicationRecord
  validates :location_id, uniqueness: true
  validates :state, presence: true

  has_many :temperatures
end
