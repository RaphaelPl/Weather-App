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
    puts "Suburb:"
    input_suburb = gets.chomp
    puts "State:"
    input_state = gets.chomp
    result = Geocoder.search("#{input_suburb}, #{input_state}")                                     #geocoder search, using user input
    return Location.new(input_suburb,ForecastIO.forecast(result[0].latitude,result[0].longitude))   #using geocoder longatude and latitude to get forecast data and initialise a location veriable,
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
    place = location_assign             #execute method from line 10 
    place.daily_weather                 #execute class method from location
    table = place.display(table)        #execute class method from location, see location file for detailed comments
    puts table
    puts "Would you like to add an aditional location?"
    if gets.downcase.chomp != 'yes'
        puts "Thanks for using Geo-Weather!\nHave a good day!"
        additional = false              #stops loop if user does not wish to make an additional search
    end
end