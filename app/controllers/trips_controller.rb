class TripsController < ApplicationController

  def index
    @restaurant = Restaurant.new
    @accommodation = Accommodation.new
    @activity = Activity.new
    @future_trips = current_user.trips.future
    @past_trips = current_user.trips.past
    @wishlist_trips = current_user.trips.wishlist
  end

  def show
    @trip = Trip.find(params[:id])
    @participation = Participation.new
    @participation.trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @participation = Participation.new
      @participation.user = current_user
      @participation.trip = @trip
      @participation.save
      redirect_to trips_path
    else
      render :new
    end
  end

  def add_participant
    @participation = Participation.new
    @participation.trip = Trip.find(params[:id])
    redirect_to trip_partipations(@participation.trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :photo, :start_date, :end_date, :description, :name)
  end

end
