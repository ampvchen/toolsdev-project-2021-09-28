# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Location.create(
  location_id: 'AUS1',
  nickname: 'Austin HQ',
  city: 'Austin',
  state: 'TX',
  country: 'United States',
  lat: 30.404251,
  long: -97.849442
)

Location.create(
  location_id: 'AUS2',
  nickname: 'Four Points',
  city: 'Austin',
  state: 'TX',
  country: 'United States',
  lat: 30.268525,
  long: -97.740958
)

Location.create(
  location_id: 'SFO1',
  city: 'San Francisco',
  state: 'CA',
  country: 'United States',
  lat: 37.787930,
  long: -122.402592
)

Location.create(
  location_id: 'SYD1',
  city: 'Sydney',
  country: 'Australia',
  lat: -33.868279,
  long: 151.208678
)

Location.create(
  location_id: 'DUB1',
  city: 'Dublin',
  country: 'Ireland',
  lat: 53.339484,
  long: -6.252009
)

Location.create(
  location_id: 'IEV1',
  city: 'Kyiv',
  country: 'Ukraine',
  lat: 50.467021,
  long: 30.447241
)

Location.create(
  location_id: 'LCY1',
  city: 'London',
  country: 'United Kingdom',
  lat: 51.507737,
  long: -0.073803
)

