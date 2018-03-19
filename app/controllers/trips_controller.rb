class TripsController < ApplicationController

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
