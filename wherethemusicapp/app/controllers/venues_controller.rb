 class VenuesController < ApplicationController

  	require 'rest-client'
	require 'json'

  url = "http://api.songkick.com/api/3.0/metro_areas/7644/calendar.json?apikey=RU3SDbXa8aLvAcbX"
	
  response = RestClient.get(url)

  parsed_response = JSON.parse(response)

  posts = parsed_response['resultsPage']['results']['event']

  venue = posts.map { |post| "#{post['venue']['displayName']}" }

end