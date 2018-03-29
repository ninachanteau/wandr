class TransportationsController < ApplicationController

def index
  @trip = Trip.find(params[:trip_id])
  @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
  @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
  @avatar = current_user.avatar
  @my_transportations = @current_participation.transportations
  @all_reservations = @trip.transportations.all
  @all_transportations = []
  @trip.all_transportations.each do |key, _value|
    @all_transportations << @all_reservations.where(departure_port:key[0], arrival_port:key[1], departure_date:key[2], arrival_date:key[3], status:key[4]).first unless @all_reservations.where(departure_port:key[0], arrival_port:key[1], departure_date:key[2], arrival_date:key[3]).nil?
  end
  @others_transportations = @all_transportations - @my_transportations
  @transportations_unsorted = @others_transportations.reject { |resa| resa unless (resa.same_reservation(@current_participation) & @my_transportations).empty? }
  @transportations = @transportations_unsorted.sort_by { |transpo| transpo.departure_date}
  @trip_participants =  @trip.participations
  @transportation = Transportation.new
  #session[:notifications][:transportation] = Time.now

  @trip_dates = {
    start_date: @trip.start_date,
    end_date: @trip.end_date
  }

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
  @resto_participants = @trip_participants.select { |part| part if params[part.pseudo] == "1"}
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
