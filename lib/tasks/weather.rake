require 'uri'
require 'net/http'
namespace :weather do
  desc "Initialize weather with 1 month of data"
  task :init => :environment do
    # TODO: check all locations
    location = Location.first


    # TODO: Handle errors
    res = init_weather(
      "#{location.lat},#{location.long}"
    )

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)['data']['weather'].each do |day|
        day['hourly'].each do |hour|
          date = hour['UTCdate']
          time = hour['UTCtime']
          time = '000' if time.eql?('0')

          datetime = "#{date} #{time[0..(time.length - 3)]}:#{time[(time.length - 2)..time.length]}:00".to_datetime.utc
          temp_c = hour['tempC']
          temp_f = hour['tempF']
          weather_desc = hour['weatherDesc']

          puts "datetime: #{datetime.inspect}"
          t = Temperature.create(
            location: location,
            datetime: datetime,
            temp_c: temp_c,
            temp_f: temp_f,
            weather_desc: weather_desc
          )

          puts "Created: #{t.inspect}"
        end
      end
    end
  end

  desc "Update weather"
  task :update => :environment do
  end

  private

  def init_weather(location)
    uri = URI('https://api.worldweatheronline.com/premium/v1/past-weather.ashx')
    params = {
      q: location,
      extra: 'utcDateTime',
      date: 1.month.ago.strftime('%F'),
      tp: 1,
      enddate: Date.today.strftime('%F'),
      format: 'json',
      key: ENV['WEATHERAPI_KEY']
    }
    uri.query = URI.encode_www_form(params)

    Net::HTTP.get_response(uri)
  end
end
