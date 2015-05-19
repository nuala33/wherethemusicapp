class Venue
	def self.from_location(latitude, longitude)
		url = "http://api.songkick.com/api/3.0/search/locations.json?location=geo:#{latitude},#{longitude}&apikey=RU3SDbXa8aLvAcbX"
		response = RestClient.get(url)
		parsed_response = JSON.parse(response)

		metro_id = parsed_response['resultsPage']['results']['location'][0]['metroArea']['id']

		metro_url = "http://api.songkick.com/api/3.0/metro_areas/#{metro_id}/calendar.json?apikey=RU3SDbXa8aLvAcbX"
		metro_response = RestClient.get(metro_url)
		metro_parsed_response = JSON.parse(metro_response)

		venues = metro_parsed_response['resultsPage']['results']['event']
		#venues = venues[0..4]
		venues_with_coordinates = venues.reject do |venue|
			venue['venue']['lat'].nil? || venue['venue']['lng'].nil? || venue['venue']['displayName'] == "Unknown venue"
		end


		Rails.cache.fetch("#{latitude}, #{longitude}", expires_in: 600) do
			venues_with_coordinates.map do |venue|
				{
					name: venue['venue']['displayName'],
					#date: venue['end']['date'],
					artist: venue['displayName'],
					link: venue['uri'],
			    latitude: venue['venue']['lat'],
			    longitude: venue['venue']['lng'],
			    street: get_address(venue['venue']['id'])
			    #website: get_address(venue['venue']['website'])
			  }
			end
		end
	end

	def self.get_address(venue_id)
		address_url = "http://api.songkick.com/api/3.0/venues/#{venue_id}.json?apikey=RU3SDbXa8aLvAcbX"
		address_response = RestClient.get(address_url)
		address_parsed_response = JSON.parse(address_response)
		address_parsed_response['resultsPage']['results']['venue']['street']
	end

	#def self.get_website(venue_website)
#		address_url = "http://api.songkick.com/api/3.0/venues/#{venue_id}.json?apikey=RU3SDbXa8aLvAcbX"
#		address_response = RestClient.get(address_url)
#		address_parsed_response = JSON.parse(address_response)
#		address_parsed_response['resultsPage']['results']['venue']['website']
#	end


end