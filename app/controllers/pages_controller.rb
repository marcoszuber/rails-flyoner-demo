class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @aircrafts = Aircraft.all.sample(6)
    @booking = Booking.new
  end
end
