Request required gems
require 'forecast_io'
require 'time'
require 'terminal-table'
#Set up classes
class Location
    attr_reader :days, :data, :name

    def initialize(name,data)
        @name = name
        @data = data.to_hash
        @days = [{},{},{},{},{},{},{},{}]
    end

    #method for getting and storing the data that we actually want in a easier to access format.
    def daily_weather
        i = 0
        #loop through each hash in the array and store values to keys.
        while i <8 
            @days[i].store("date",Time.at(@data['daily']['data'][i]['time']).to_s)
            @days[i].store("summary",@data['daily']['data'][i]['summary'])
            @days[i].store("temp_high",@data['daily']['data'][i]['temperatureHigh'])
            @days[i].store("temp_low",@data['daily']['data'][i]['temperatureLow'])
            @days[i].store("precip_type",@data['daily']['data'][i]['precipType'])
            @days[i].store("precip_chance",@data['daily']['data'][i]['precipProbability'])
            i += 1
        end
    end

    def display(table)
        i = 0
        table.add_separator
        #adding name to the display table
        table.add_row([@name,'','','','',''])
        #looping through stored data to populate display table
        while i <8
            row = []
            row << [@days[i]['date'].slice(0,10)]       #remove unnessisary time information stored in line 21
            row << [@days[i]['summary']]
            row << [@days[i]['temp_high']]
            row << [@days[i]['temp_low']]
            row << [@days[i]['precip_type']]
            row << [@days[i]['precip_chance']]
            table.add_row(row)
            i += 1
        end
        return table
    end

end

#set api for weather access
ForecastIO.api_key = '05cd0f8759c4e210a946e69d9b339a45'
#set default parameters for weather gem
ForecastIO.default_params = { units: 'si' }
#getting data for given location and storing it as a hash
spring_hill = Location.new('Spring_Hill',ForecastIO.forecast(-27.4600,153.0260))
table = Terminal::Table.new :headings => ['Date', 'Summary','High','Low','Type','Chance']
spring_hill.daily_weather
table = spring_hill.display(table)
puts table 