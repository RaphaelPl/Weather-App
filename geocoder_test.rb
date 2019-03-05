require 'geocoder'


result = Geocoder.search("Times square, Sunnybank")
latitude = city[0].latitude
longitude = city[0].longitude

#puts "#{city}"
puts "#{latitude}"
puts "#{longitude}"
puts result




