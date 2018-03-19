class TransportationsController < ApplicationController

def index
  @trip = Trip.find(params[:id])
  @transportations = trip.transportations.all
end



end
