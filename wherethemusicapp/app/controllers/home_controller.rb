class HomeController < ApplicationController

  def index
    if params[:q]
    	@latitude, @longitude = Geocoder.coordinates(params[:q])
			@allvenues = Venue.from_location(@latitude, @longitude)
			unless @allvenues.class == Array
			  if @allvenues.http_code == 400
				  @allvenues = nil
				  flash.now[:alert] = 'NO VENUES HERE'
			  end
			end


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