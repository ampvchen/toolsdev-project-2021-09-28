class TemperaturesController < ApplicationController
  before_action :set_location, only: %i[index forecast high_low]

  def index
    @temperatures = Temperature.where(location: @location)
    temperatures_arr = []

    @temperatures.each do |temperature|
      temperatures_arr.push([
                                 temperature.datetime.to_i.to_i * 1000,
                                 temperature.temp_f
                               ])
    end

    forecast_arr = get_forecast("#{@location.lat}, #{@location.long}")

    respond_to do |format|
      format.json { render json: [temperatures_arr, forecast_arr], status: :ok }
    end
  end

  def high_low
    ref = get_high_low(@location, @location.temperatures.first.datetime)
    respond_to do |format|
      format.json { render json: ref, status: :ok}
    end
  end

  private

  def get_forecast(location)
    # Proxy the request
    # TODO: Add caching
    uri = URI('https://api.worldweatheronline.com/premium/v1/weather.ashx')
    params = {
      q: location,
      extra: 'utcDateTime',
      num_of_days: 3,
      tp: 1,
      format: 'json',
      key: ENV['WEATHERAPI_KEY']
    }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    json = []
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)['data']['weather'].each do |day|
        day['hourly'].each do |hour|
          date = hour['UTCdate']
          time = hour['UTCtime']
          time = '000' if time.eql?('0')

          datetime = "#{date} #{time[0..(time.length - 3)]}:#{time[(time.length - 2)..time.length]}:00".to_datetime
          temp_f = hour['tempF'].to_i

          json.push(
            [(datetime.to_i.to_i * 1000),
             temp_f]
          )
        end
      end
    end

    json
  end

  def get_high_low(location, start, arr = [[], []])
    finish = start + 3.hours
    obj = location.temperatures.where(datetime: start..finish)
    return arr if obj.count.eql?(0)

    # Not sure if it should index on start or finish time
    finish_ms = finish.to_i * 1000
    arr[0].push([finish_ms, obj.pluck(:temp_f).max])
    arr[1].push([finish_ms, obj.pluck(:temp_f).min])

    get_high_low(location, finish, arr)
  end

  def set_location
    @location = Location.find(params[:location_id])
  end
end
