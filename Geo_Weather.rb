#Request required gems
require 'forecast_io'
require 'geocoder'
require 'time'
require 'terminal-table'
#Request Location class
require_relative "./Location"

#prompting user input in two parts to improve accuracy of geocoder search. Initialising new location using user suburb name and forecast data recieved from search.
def location_assign
    result = []
    entry_error = true
    while entry_error == true                                       #loop for string validation
        puts "Suburb:"
        input_suburb = gets.chomp
        puts "State:"
        input_state = gets.chomp
        begin                                                       #Block - forces user input into a float. If successful, user input is not english words and thus not valid
            Float(input_state)          
            Float(input_suburb)
            puts "Please enter english name for locations."
        rescue ArgumentError                                        #rescues from error that will occur when user enters correctly formatted input
            entry_error = false
        end
    end
    result = Geocoder.search("#{input_suburb}, #{input_state}")     #geocoder search, using user input
    return Location.new("#{result[0].city}, #{result[0].state}",ForecastIO.forecast(result[0].latitude,result[0].longitude))   #using geocoder longatude and latitude to get forecast data and initialise a location veriable,
end

#validates user input in regards to whether they wish to add an aditional location
def another
    loop do
        case gets.downcase.chomp        #loops until user input is either yes or no; returns true or false respectively
        when 'no'
            return false
        when 'n'
            return false                
        when 'yes'
            return true
        when 'y'
            return true
        else
            next
        end
    end
end 

#set api for weather access
ForecastIO.api_key = 'YOUR API KEY HERE'
#set default parameters for weather gem
ForecastIO.default_params = { units: 'si' }
#initialising variables
additional = true
table = Terminal::Table.new :headings => ['Date', 'Summary','High','Low','Type','Chance']           #setting up table with headings

puts "Welcome to Geo-Weather!\nEnter a location to begin!"
#getting user input, searching location, getting weather data, populating table with data
while additional == true
    begin
        place = location_assign             #execute method from line 10 
        place.daily_weather                 #execute class method from location
        table = place.display(table)        #execute class method from location, see location file for detailed comments
        puts table
        puts "Would you like to add an additional location?"
        additional = another
    rescue NoMethodError                    #rescues from fatal error occuring when users enter a location that cannot be found by search
        puts "No location matching the supplied details found.\nPlease enter a real location."
    end
end
puts "Thankyou for using Geo-Weather.\nHave a good day!"        #informs user that they should have a good day