class Location < ApplicationRecord
  # TODO: Refactor :location_id to :code
  validates :location_id, uniqueness: true
  validates :city, presence: true

  has_many :temperatures
end
