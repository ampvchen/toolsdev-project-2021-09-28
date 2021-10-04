namespace :scheduler do
  task update_weather: :environment do
    UpdateWeatherJob.perform_later
  end
end
