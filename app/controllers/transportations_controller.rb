class TransportationsController < ApplicationController

def index
  @trip = Trip.find(params[:trip_id])
  @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id)
  @avatar = current_user.avatar
  @transportations = @trip.transportations.all
end

def new
  @trip = Trip.find(params[:trip_id])
  @transportation = Transportation.new
end

def create
  @trip = Trip.find(params[:trip_id])
  @transportation = Transportation.create(transpo_params)
  @transportation.trip = @trip
  @trip.save
  redirect_to trip_transportations_path(@trip)
end


def edit
  @transportation = Transportation.find(params[:id])
end

def update
  @trip = Trip.find(params[:trip_id])
  @transportation = Transportation.find(params[:id])
  @transportation.update(status: params[:status])
  @transportation.save
  redirect_to trip_transportations_path(@trip)
end

def destroy
  @transportation = Transportation.find(params[:id])
  @transportation.destroy
  redirect_to trip_transportations_path(@trip)
end

private

def transpo_params
  params.require(:transportation).permit(:status)

end

end
