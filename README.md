# Weather-App
CA week three terminal app - Matt and Raph 


Geo-Weather
========

a weather forecast solution that for a searchable worldwide weather search

[Link to github repo](https://github.com/raphaCA/geocoder)

****

Key features:

* simple user search for suburb and state, also accepts only suburb and is searchable by landmark
* Connects to DarkSky API for realtime 7 day worldwide weather forecast
* returns forecast to an easy to read table


Table of Contents
-----------------

Basic Features:

* [Description](#Description)
  [Functionality](#Functionality)
* [Instructins for use](#Instructions_for_use)
* [Design and planning process](#design_and_planning_process)
  * app idea brainstorming
  * user flow
  * project plan 
  [Future_iterations](#Future_Iterations)


Description
------------

Geo-Weather is a searchable app that takes input from a user to make a search for their chosen loctation and provide them with a weather forecast for the current day and the following seven days. 

This is then used to populate a table diplaying the results for the user.

```
Welcome to Geo-Weather!
Enter a location to begin!
Suburb:
Brisbane
State:
QLD
+----------------------+----------------------------------------------+------+------+----------+---------+
| Date                 | Summary                                      | High | Low  | Type     | Chance  |
+----------------------+----------------------------------------------+------+------+----------+---------+
+----------------------+----------------------------------------------+------+------+----------+---------+
| Brisbane, Queensland |                                              |      |      |          |         |
| ["2019-03-07"]       | ["Light rain starting in the afternoon."]    | [31] | [22] | ["rain"] | ["64%"] |
| ["2019-03-08"]       | ["Mostly cloudy throughout the day."]        | [29] | [22] | ["rain"] | ["57%"] |
```

 Functionality
-----------------

Geo-Weather uses a combination of the Geocoder Gem, the ForecastIO Gem and Terminal-Table to grab the user input, send it off to to the DarkSky API for a set of data returned based on the search query. This is then stored for passing into a method that grabs this extracted data and creates a table for ease of use by the user. 

The functionality of the app is dependent on an active network connection as the data is being pulled from [DarkSky_link](https://darksky.net/forecast/40.7127,-74.0059/us12/en) through the API.


*example of code used for search query*

```
city = Geocoder.search("Times square, Sunnybank")
latitude = city[0].latitude
longitude = city[0].longitude

ForecastIO.forecast(result[0].latitude,result[0].longitude)
```

Instructions for Use
------------------------------------------

User is required to use the following gems and requires to run the app, 

*prerequisite Gem installation*

sudo gem install Forecast

sudo gem install geocoder

sudo gem install terminal-table

require 'forecast_io'

require 'geocoder'

require 'time'

require 'terminal-table'

require_relative "./Location"


The app requires the user to run the two files, Geo_Weather.rb and Location.rb and use the following command to begin the app,

*ruby "Geo_Weather.rb"*

Upon startup the user is welcomed and asked to select a location, this data can be entered using uppercase or downcase. 

```
Welcome to Geo-Weather!
Enter a location to begin!

Suburb:
brisbane
State:
QLD
```

Once these details are filled the user waits a short time (a couple of seconds) while the requests for both location and weather info are made.

If this search query fails for either spelling errors or inabilty to find a location based on the input, the user is prompted to 
make further input based. 

*please note users are able to omit state details from search field
it just affects the accuracy and time of the search and is not encouraged*


```
No location matching the supplied details found.
Please enter a real location.
```

The user is then provided with a table formatted for the location they selected.

```
+----------------------+----------------------------------------------+------+------+----------+---------+
| Date                 | Summary                                      | High | Low  | Type     | Chance  |
+----------------------+----------------------------------------------+------+------+----------+---------+
+----------------------+----------------------------------------------+------+------+----------+---------+
| Brisbane, Queensland |                                              |      |      |          |         |
| ["2019-03-07"]       | ["Light rain starting in the afternoon."]    | [31] | [22] | ["rain"] | ["64%"] |
| ["2019-03-08"]       | ["Mostly cloudy throughout the day."]        | [29] | [22] | ["rain"] | ["57%"] |
| ["2019-03-09"]       | ["Mostly cloudy until afternoon."]           | [30] | [22] | ["rain"] | ["20%"] |
| ["2019-03-10"]       | ["Partly cloudy until evening."]             | [30] | [22] | ["rain"] | ["11%"] |
| ["2019-03-11"]       | ["Mostly cloudy starting in the afternoon."] | [33] | [23] | [nil]    | ["0%"]  |
| ["2019-03-12"]       | ["Light rain starting in the evening."]      | [34] | [22] | ["rain"] | ["29%"] |
| ["2019-03-13"]       | ["Partly cloudy in the morning."]            | [31] | [22] | ["rain"] | ["36%"] |
| ["2019-03-14"]       | ["Overcast throughout the day."]             | [29] | [22] | ["rain"] | ["77%"] |
+----------------------+----------------------------------------------+------+------+----------+---------+
```

The user is then asked if they wish to continue by selecting another location or exiting. This is done by selecting y, yes or n, no. 

```
Would you like to add an aditional location?
no
Thankyou for using Geo-Weather.
Have a good day!
```

The app will then exit or continue to run based on this selection.

*troubleshooting -- a common issue will be incorrect input of data, this is caught 
with a rescue and an internal data validation to ensure the data entered is a string
future iterations of the app will support long and lat inputs*


Design and Planning Process
----------------------------

evidence of planning in trello board

[trello](./docs/trello.png)

evidence of collabaration in slack

[slack](./docs/slack.png)


### App idea brainstorming
The initial idea was floated between us both and decided upon rather quickly as it was a challenging and slightly ambitious idea. 
Brainstorming the idea fleshing out a plan for the way the app would function and what would be required to bring this to life.

The intial sessions involved creating the trello board and planning the stages of development featuring the following  

#### scope 
User input to provide a forecast
Get user location automatically based on IP (geo)
-provide the user with forecast elements based on input they pass in

#### initial pre-planning
Save history/locations ----- read/write file to be loaded on startup of app
Add locations
Remove locations
Display forecast

#### begin to explore required elements
ForecastIO
Research API usage to obtain weather data
Get trial with google API’s to use geolocation 
Obtain API key ---- forecast.io needs API key

Geocoder
How does gem get it’s data, how to integrate this data into app
How pull forecast from this data
How do users input or provide this data

### User flow

[user_flow](./docs/flow.png)


### Project plan

*please note each stage involved testing of the elements listed

- Begin installation of gems and research how the gems work 
- extract data from searches 
- design code base from research into the data returned from searches
- create containers for storing data
- use stored data to then display to user
- test code design for errors
- error correction
- testing for data validation
- create blocks for rescues of invalid data
- final testing 
- further testing 

Testing 
----------------------------

see sheet linked for test cases

[testing](./docs/test.pdf)

Future Iterations
----------------------------

update to use non english language support
allow input of longitude and latitude as search queries
broaden user messages to encourage search for place names and landmarks
future support for ip address lookpup
output history files 
future iteration will allow for time machine lookup of both past and future forecasts
