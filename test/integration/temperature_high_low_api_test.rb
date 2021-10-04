require 'test_helper'

class TemperatureHighLowApiTest < ActionDispatch::IntegrationTest
  test "can request high_low data" do
    get '/locations/1/temperatures/high_low.json'
  end

  test "high_low data properly formatted" do
    get '/locations/1/temperatures/high_low.json'
    assert JSON.parse(@response.body).length.eql?(2)
  end

  test "temperature data has historical data" do
    get '/locations/1/temperatures/high_low.json'
    assert JSON.parse(@response.body).first.length
             .eql?(Temperature.all.count/3)
  end
end
