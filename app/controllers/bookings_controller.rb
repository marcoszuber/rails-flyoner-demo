class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @aircraft = Aircraft.find(params[:aircraft_id])
    @booking = Booking.new
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.aircraft = @aircraft
    @booking.save

=begin
    if @booking.save
      redirect_to @booking, notice: "booking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
=end
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: "booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_url, notice: "booking was successfully destroyed."
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:name, :seats, :price, :description)
  end
end
