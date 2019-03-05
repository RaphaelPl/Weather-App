require 'faraday'
require 'forecast_io'

ForecastIO.api_key = '05cd0f8759c4e210a946e69d9b339a45'

p spring_hill_forecast = ForecastIO.forecast(-27.4600,153.0260) 