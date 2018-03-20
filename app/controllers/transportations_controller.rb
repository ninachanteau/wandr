class TransportationsController < ApplicationController

def index
  @trip = Trip.find(params[:trip_id])
  @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id)
  @avatar = current_user.avatar
  @transportations = @trip.transportations.all
end



end
