class RestaurantsController < ApplicationController
  include RestaurantsHelper
  def index
    if !!location_params
      user_location = {
        coords: {
          latitude: location_params[:lat],
          longitude: location_params[:long]
        }

      }
      near_restaurants = get_restaurant_panes(user_location)
      # FOR TESTING SO YOU DON'T USE ALL THE API CALLS
      # near_restaurants = Restaurant.all

      render partial: 'index', layout: false, locals: {restaurants: near_restaurants} , status: :ok
    else
      puts '*'*50
      puts "restuarantes set"
      puts '*'*50
      @restaurants = Restaurant.all
    end
  end

private
  def location_params
    if params.has_key?(:coords)
      params.require(:coords).permit(:lat, :long)
    else
      false
    end
  end
end
