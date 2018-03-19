class TripsController < ApplicationController

  def index
    @trips = current_user.future_trips
    @past_trips = current_user.past_trips
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
