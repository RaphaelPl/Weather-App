#Request required gems
require 'forecast_io'
require 'time'
#Set up classes
class Location
    attr_reader :days, :data, :name

    def initialize(name,data)
        @name = name
        @data = data.to_hash
        @days = [{},{},{},{},{},{},{},{}]
    end

    #method for storing the data that we actually want.
    def daily_weather
        i = 0
        #loop through each hash in the array and store values to keys.
        while i <8 
            @days[i].store("date",Time.at(@data['daily']['data'][i]['time']))
            @days[i].store("summary",@data['daily']['data'][i]['summary'])
            @days[i].store("temp_high",@data['daily']['data'][i]['temperatureHigh'])
            @days[i].store("temp_low",@data['daily']['data'][i]['temperatureLow'])
            @days[i].store("precip_type",@data['daily']['data'][i]['precipType'])
            @days[i].store("precip_chance",@data['daily']['data'][i]['precipProbability'])
            i += 1
        end
    end
end
#set api for weather access
ForecastIO.api_key = 'YOUR API KEY HERE'
#set default parameters for weather gem
ForecastIO.default_params = { units: 'si' }
#getting data for given location and storing it as a hash
spring_hill = Location.new('Spring_Hill',ForecastIO.forecast(-27.4600,153.0260))
spring_hill.daily_weather
puts spring_hill.days