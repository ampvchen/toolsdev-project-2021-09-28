require 'test_helper'

class TemperatureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test 'should not save temperature if one exists for same location and time' do
    datetime = DateTime.now

    Temperature.create(
      location_id: 1,
      datetime: datetime
    )

    temperature = Temperature.create(
      location_id: 1,
      datetime: datetime
    )

    assert_not temperature.save

  end
end
