class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def index
    @bookings = Booking.all.where(user_id: current_user.id)
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
    start_time = params[:booking][:start_time]
    if params[:booking][:finish_time].present?
      params[:booking][:finish_time] = params[:booking][:finish_time]
    else
      params[:booking][:finish_time]  = start_time
    end
    @aircraft = Aircraft.find(params[:aircraft_id])
    @booking = Booking.new(booking_params)
    @booking.aircraft = @aircraft
    @booking.user = current_user
    @booking.total_price = ((@booking.finish_time.try(:to_date) - @booking.start_time.try(:to_date)).to_i * @booking.aircraft.price)


    if @booking.save
      #Envia Notificacion de email
      @booking.total_price = 1222
      @user = current_user
      UserNotifierMailer.send_booking_email(@user, @booking).deliver_later
      #redirect_to bookings_path
      if params[:from].present?
      @booking.add_empty_leg
      redirect_to new_booking_payment_path(@booking)
    else
      flash[:alert] = @booking.errors.full_messages[0]

      # @alert = "ups algo a salido mal, estas intentando de bookear fechas ya bookeadas o estan mal las fechas"
      # flash[:alert] = @alert
      render "aircrafts/show", status: :unprocessable_entity
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: "booking was successfully updated."
    else
      flash[:alert] = @booking.errors.full_messages[0]
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
    #params.require(:booking).permit(:name, :seats, :price, :description)
    params.require(:booking).permit(:start_time, :finish_time, :aircraft_id, :from, :to, :total_price)
  end
end
