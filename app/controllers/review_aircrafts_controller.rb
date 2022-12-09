class ReviewAircraftsController < ApplicationController

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

    before_action :set_review_aircraft, only: %i[show edit update destroy]
    skip_before_action :authenticate_user!, only: %i[index show]
    
  
    def index
      @aircraft = Aircraft.find(params[:aircraft_id])
      @review_aircrafts = ReviewAircraft.where(aircraft_id: @aircraft.id)
      console
    end
  
    def show
      
    end
  
    def new
      @booking = Booking.find(params[:booking_id])
      @review_aircraft = ReviewAircraft.new
    end

    def create
      @review_aircraft = ReviewAircraft.new(review_aircraft_params)
      @booking = Booking.find(params[:booking_id])
      @review_aircraft.aircraft = @booking.aircraft
      @review_aircraft.user = current_user
      
      if @review_aircraft.save
        redirect_to booking_review_aircrafts_path(@booking), notice: "review successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def edit
    end
  
    def update
      if @review_aircraft.update(review_aircraft_params)
        redirect_to @review_aircraft, notice: "review successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    #def destroy
    #  @review_aircraft.destroy
    #  redirect_to review_aircrafts_url, notice: "review successfully destroyed."
    #end
  
    private
  
    def set_review_aircraft
      @review_aircraft = ReviewAircraft.find(params[:id])
    end
  
    def review_aircraft_params
      params.require(:review_aircraft).permit(:stars, :description)
    end

end

#t.float "stars"
#t.text "description"
#t.bigint "aircraft_id", null: false
#t.datetime "created_at", null: false
#t.datetime "updated_at", null: false
#t.bigint "user_id"
#t.index ["aircraft_id"], name: "index_review_aircrafts_on_aircraft_id"
#t.index ["user_id"], name: "index_review_aircrafts_on_user_id"