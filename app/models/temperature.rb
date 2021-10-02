class Temperature < ApplicationRecord
  serialize :weather_desc, Array

  belongs_to :location
end
