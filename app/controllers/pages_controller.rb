class PagesController < ApplicationController
  def home
    @aircrafts = Aircraft.all.sample(12)
    @booking = Booking.new
  end
end
