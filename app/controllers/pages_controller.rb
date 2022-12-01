class PagesController < ApplicationController
  def home
    @aircrafts = Aircraft.all.sample(6)
    @booking = Booking.new
  end
end
