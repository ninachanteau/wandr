class TransportationsController < ApplicationController

def index
  @trip = Trip.find(params[:trip_id])
  @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
  @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
  @avatar = current_user.avatar
  @transportations = @trip.transportations.all
  @trip_participants =  @trip.participations
  @transportation = Transportation.new
  respond_to do |format|
    format.html
    format.js
  end
end

def new
  @trip = Trip.find(params[:trip_id])
  @transportation = Transportation.new
  @transportation.trip = @trip
end

def create
  @trip = Trip.find(params[:trip_id])
  @transportation = Transportation.new(transpo_params)
  @trip_participants =  @trip.participations
  @transpo_participants = @trip_participants.select { |part| part if params[part.pseudo] == "1"}
  if @transportation.save!
      @transpo_participants.each do |part|
        @transportation.add_participant(part)
      end
        redirect_to trip_transportations_path(@trip)
    else
      render 'new'
    end
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
  @trip = Trip.find(params[:trip_id])
  @transportation = Transportation.find(params[:id])
  @transportation.destroy
  redirect_to trip_transportations_path(@trip)
end

private

def transpo_params
  params.require(:transportation).permit(:status, :departure_port, :departure_date, :arrival_port, :arrival_date, :price_per_person, :reference_number)
end



end
