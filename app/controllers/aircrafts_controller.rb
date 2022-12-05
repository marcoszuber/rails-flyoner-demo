class AircraftsController < ApplicationController
  before_action :set_aircraft, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]
  

  def index
    if params[:finish_time].present? 
      start_date = params[:start_time].try(:to_date) || DateTime.now
      end_date = params[:finish_time].try(:to_date) || DateTime.now + 30.days
      bookings = Booking.where(start_time: start_date..end_date).or(Booking.where(finish_time: start_date..end_date))
      @aircrafts = Aircraft.where.not(id: bookings.map(&:aircraft_id))
    else
      @aircrafts = Aircraft.all
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @aircraft = Aircraft.new
  end

  def edit
  end

  def create
    @aircraft = Aircraft.new(aircraft_params)
    @aircraft.user = current_user
    if @aircraft.save
      redirect_to @aircraft, notice: "aircraft was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @aircraft.update(aircraft_params)
      redirect_to @aircraft, notice: "aircraft was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @aircraft.destroy
    redirect_to aircrafts_url, notice: "aircraft was successfully destroyed."
  end

  private

  def set_aircraft
    @aircraft = Aircraft.find(params[:id])
  end

  def aircraft_params
    params.require(:aircraft).permit(:name, :seats, :price, :description, photos: [])
  end
end
