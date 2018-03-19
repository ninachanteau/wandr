class TripsController < ApplicationController

  def index
    @trips = Trip.all.future_trips
    @past_trips = Trip.all.past_trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.create(trip_params)
    redirect_to trip_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permet(:destination, :photo, :start_date, :end_date, :description, :name)
  end

end
