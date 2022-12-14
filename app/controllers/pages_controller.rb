class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @air = Aircraft.all
    @aircrafts = @air.where(status: true).sample(6)
    @booking = Booking.new
  end
end
