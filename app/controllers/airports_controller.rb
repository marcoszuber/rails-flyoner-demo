class AirportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: %i[index show price]
  def price
    if params[:start_airport_id].present? and params[:finish_airport_id].present?
      start_airport = Airport.find(params[:start_airport_id].to_i)
      finish_airport = Airport.find(params[:finish_airport_id].to_i)
      distances = Geocoder::Calculations.distance_between([start_airport.lat, start_airport.lon], [finish_airport.lat, finish_airport.lon])
      distances = distances.round(0)
      distances *= 10
    else
      distances = 0
    end
    render json: { price: distances }
  end
end
