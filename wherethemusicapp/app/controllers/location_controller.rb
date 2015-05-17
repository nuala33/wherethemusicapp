class LocationController < ApplicationController

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new

   # if @location.save
    #  redirect_to @location
    #else
     # render :new
    end
  #end
end