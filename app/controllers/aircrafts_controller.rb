class AircraftsController < ApplicationController
  before_action :set_aircraft, only: %i[show edit update destroy]

  def index
    @aircrafts = Aircraft.all
  end

  def show
  end

  def new
    @aircraft = Aircraft.new
  end

  def edit
  end

  def create
    @aircraft = Aircraft.new(aircraft_params)

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
    params.require(:aircraft).permit(:name, :seats, :price, :description)
  end
end
