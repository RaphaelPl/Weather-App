require 'geocoder'


city = Geocoder.search("0, 0")
latitude = city[0].latitude
longitude = city[0].longitude

#puts "#{city}"
puts "#{latitude}"
puts "#{longitude}"
puts city
 

x = 13.3424.round
puts "#{x}"