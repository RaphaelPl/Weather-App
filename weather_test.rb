require 'faraday'
require 'forecast_io'

ForecastIO.api_key = 'Your API here'

p spring_hill_forecast = ForecastIO.forecast(-27.4600,153.0260) 

ForecastIO.default_params = { units: 'si' }
spring_hill_forecast = ForecastIO.forecast(-27.4600,153.0260)
spring_hill_forecast = spring_hill_forecast.to_hash
spring_hill_forecast["daily"].each do |key, value|
   puts "key name: #{key}\tKey type: #{key.class}\tValue type: #{value.class}"
end