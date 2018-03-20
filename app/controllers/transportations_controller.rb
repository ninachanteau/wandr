class TransportationsController < ApplicationController

def index
  @trip = Trip.find(params[:trip_id])
  @transportations = @trip.transportations.all
end



end
