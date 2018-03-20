class TripsController < ApplicationController

  def index
    @future_trips = current_user.trips.future
    @past_trips = current_user.trips.past
    @wishlist_trips = current_user.trips.wishlist
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trips_path
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permet(:destination, :photo, :start_date, :end_date, :description, :name)
  end

end
