class EmptyLegsController < ApplicationController

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  before_action :set_empty_leg, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]


  def index
    @aicraft = Aircraft.all
    if params[:finish_time].present?
      start_date = params[:start_time].try(:to_date) || DateTime.now
      end_date = params[:finish_time].try(:to_date) || DateTime.now + 30.days
      bookings = Booking.where(start_time: start_date..end_date).or(Booking.where(finish_time: start_date..end_date))
      @empty_legs = EmptyLeg.where.not(id: bookings.map(&:empty_leg_id))
      @aircrafts = Aircraft.where.not(id: bookings.map(&:aircraft_id)).where(status: true)
      @aircrafts = Aircraft.where(status: true)
    else
      @aircrafts = Aircraft.where(status: true)
      @empty_legs = EmptyLeg.all
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @empty_leg = EmptyLeg.new
  end

  def edit
  end

  def create
    @empty_leg = EmptyLeg.new(empty_leg_params)
    @empty_leg.user = current_user
    if @empty_leg.save
      redirect_to @empty_leg, notice: "Empty leg was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @empty_leg.update(empty_leg_params)
      redirect_to @empty_leg, notice: "Empty leg was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @empty_leg.destroy
    redirect_to empty_legs_url, notice: "Empty leg was successfully destroyed."
  end

  private

  def set_empty_leg
    @empty_leg = EmptyLeg.find(params[:id])
  end

  def empty_leg_params
    params.require(:empty_leg).permit(:name, :seats, :price, :description, photos: [])

  end
end
