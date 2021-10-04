class Temperature < ApplicationRecord
  belongs_to :location
  serialize :weather_desc, Array

  validates :datetime, uniqueness: {
    scope: :location_id,
    message: "should only have one temp per location and datetime"
  }
end
