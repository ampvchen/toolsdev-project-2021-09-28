require 'test_helper'

class TemperatureApiTest < ActionDispatch::IntegrationTest
  test "can request temperature data" do
    get '/locations/1/temperatures.json'
    assert_response :success
  end

  test "temperature data properly formatted" do
    get '/locations/1/temperatures.json'
    assert JSON.parse(@response.body).length.eql?(2)
  end

  test "temperature data has historical data" do
    get '/locations/1/temperatures.json'
    assert JSON.parse(@response.body).first.length.eql?(5)
  end

  test "temperature data has forecast data" do
    get '/locations/1/temperatures.json'
    assert JSON.parse(@response.body).second.length > 0
  end
end
