class AircraftsController < ApplicationController
  before_action :set_aircraft, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end


  def index
    if params[:finish_time].present? or params[:start_time].present? or params[:seats].present?
      start_date = params[:start_time].try(:to_date) || DateTime.now
      end_date = params[:finish_time].try(:to_date) || DateTime.now + 30.days
      seats = params[:seats].to_i || 1
      bookings = Booking.where(start_time: start_date..end_date).or(Booking.where(finish_time: start_date..end_date))
      @aircrafts = Aircraft.where.not(id: bookings.map(&:aircraft_id)).where(status: true).and(Aircraft.where.not(seats: 1..seats)) 
    else
      @aircrafts = Aircraft.where(status: true)
    end
  end

  def my_aircrafts
    @aircrafts = Aircraft.where(user: current_user.id)
  end

  def show
    @booking = Booking.new
    @review_aircraft = ReviewAircraft.where(aircraft_id: @aircraft.id)
    @airports = Airport.all
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
    params.require(:aircraft).permit(:name, :seats, :price, :description, :status, photos: [])
  end
end
