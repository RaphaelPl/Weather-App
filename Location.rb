class Location
    def initialize(name,data)
        @name = name                        #name of suburb
        @data = data.to_hash                #data retrieved from forecast_io
        @days = [{},{},{},{},{},{},{},{}]   #initialising local containers for daily weather data
    end

    #method for getting and storing the data that we actually want in a easier to access format.
    def daily_weather
        i = 0
        #loop through each hash in the array and store values to keys.
        #values are retrieved from the mash of data sent by the forecast_io
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
            row << [@days[i]['date'].slice(0,10)]       #remove unnecessary time information
            row << [@days[i]['summary']]
            row << [@days[i]['temp_high'].round]        #round temperature
            row << [@days[i]['temp_low'].round]         #ditto
            row << [@days[i]['precip_type']]
            row << ["#{(@days[i]['precip_chance']*100).round}%"]  #convert decimal to percent and round for easy viewing
            table.add_row(row)
            i += 1
        end
        return table
    end
end