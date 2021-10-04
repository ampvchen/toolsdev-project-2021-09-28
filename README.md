# Tools Dev Project

This project will show the weather for BigCommerce office locations.

## Requirements

The list of requirements to install are:

* Ruby >= 2.6.x
* Postgresql
* Redis

*Note: Ruby `2.6.8` is required for Heroku ([Support Runtimes](https://devcenter.heroku.com/articles/ruby-support#supported-runtimes)).*

## Installation

* [Install Postgresql](https://www.postgresql.org/download/)
* [Install Redis](https://redis.io/topics/quickstart)
* [Install Forman](https://github.com/ddollar/foreman)
* `git clone https://github.com/ampvchen/toolsdev-project-2021-09-28.git`
* `bundle install`
* `bundle rails db:setup`
* `bundle rails db:seed`
    * This command will setup all of the locations.
* Set `WEATHERAPI_KEY`
* `bundle exec rake weather:init`
    * This will pull one month of weather data for all of the locations created in your seeds file.
* `bundle exec foreman start`

## Configuration

Local Env variables:
* _**WEATHERAPI_KEY:**_ Get an API key [here]()
* _**SIDEKIQ_PASSWORD:**_ This is for the Basic Auth in production
* _**SNITCHER_TOKEN:**_ This is used to monitor the `weather:update` task

This is set in the `.env` file for local development. More info [here](https://github.com/bkeepers/dotenv).

## Updating the weather data

The weather data is updated through [clockwork](https://github.com/Rykian/clockwork) and configured in the `config/clock.rb` file.

This can be manually run with: `bundle exec clockwork config/clock.rb` 

## Tests

Run `rails tests`

*Tests are all written using MiniTest and Fixtures to keep dependencies low*

## Endpoints

* `/locations`
    * Show all available locations
    
* `/locations/#{:id}`
    * Get information about a specific location

* `/locations/#{:id}/temperatures`
    * Get all of the historical and forecast hourly temperatures in 2 arrays
    * \[0]: Historical data
    * \[1]: Forecast data
    
* `/locations/#{:id}/temperatures/high_low`
    * Get the high and low temperatures grouped by 3 hours blocks
    * \[0]: High data
    * \[1]: Lows data
    
* `/locations/#{:id}/temperatures/daily_average`
    * Get the average temperatures for each day
 
## Issues
* **Timezones**
    * Everything is standardized on UTC
    * The time should automatically be updated based on the Timezone
    * Timezone data should be stored on the Location
   
* **Caching**
    * Since the `forcast.json` API request proxies the call to the [https://www.worldweatheronline.com/developer/api/docs/local-city-town-weather-api.aspx] the requests could be cached for that request over the hour before it becomes stale.
    
* **Exception handling**
    * The Weather API silently fails and should raise an exception to be handled
    
* **weather:update**
    * When updating the weather, it pulls all the data for the day. It would be better to only fetch and store the relevant hour data. 


## Built with
* [Ruby on Rails](https://rubyonrails.org/)
* [jQuery](https://jquery.com/)
* [Bootstrap](https://getbootstrap.com/)
* [CoffeeScript](https://coffeescript.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [Redis](https://redis.io/)


