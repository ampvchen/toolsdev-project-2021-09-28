require 'clockwork'
require_relative '../config/boot'
require_relative '../config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.hour, 'Update weather'){ UpdateWeatherJob.perform_later args }
end
