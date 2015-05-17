class HomeController < ApplicationController

  def index
    if params[:q]
    	@latitude, @longitude = Geocoder.coordinates(params[:q])
			@allvenues = Venue.from_location(@latitude, @longitude)

#get response
#get city code
#url2 (for venues)
#get response again
#get venues

#url3 (for events)
#get response again
#get venues

    end
  end
end