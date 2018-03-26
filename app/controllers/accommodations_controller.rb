require "open-uri"
require "nokogiri"

class AccommodationsController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @my_accommodations = @current_participation.accommodations
    @trip_participants =  @trip.participations
    @all_reservations = Accommodation.where(trip_id: @trip.id)
    @all_accommodations = []
    @trip.all_accommodations.each do |key, _value|
      @all_accommodations << @all_reservations.where(name:key[0], start_date: key[1], end_date: key[2]).first unless @all_reservations.where(name:key[0], start_date: key[1], end_date: key[2]).nil?
    end
    @accommodations = @all_accommodations.reject { |resa| resa unless (resa.same_reservation & @my_accommodations).empty? }
    @accommodation = Accommodation.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @accommodation = Accommodation.new
    @trip = Trip.find(params[:trip_id])
    @accommodation.trip = @trip
    # render 'accommodations/new'
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    @trip = Trip.find(params[:trip_id])
    @accommodation.trip = @trip
    @trip_participants =  @trip.participations
    @acc_participants = @trip_participants.select { |part| part if params[part.pseudo] == "1"}
    if @accommodation.end_date && @accommodation.start_date
      @accommodation.number_of_nights = @accommodation.end_date - @accommodation.start_date
    end
    if @accommodation.save!
      @acc_participants.each do |part|
        @accommodation.add_participant(part)
      end
      redirect_to trip_accommodations_path(@trip)
    else
      render 'new'
    end
  end

  def edit
    @accommodation = Accommodation.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @accommodation = Accommodation.find(params[:id])
    @accommodation.update(status: params[:status])
    redirect_to trip_accommodations_path(@trip)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @accommodation = Accommodation.find(params[:id])
    @accommodation.destroy
    redirect_to trip_accommodations_path(@trip)
  end

  private

  def set_accommodation
    @accommodation = Accommodation.find(@accommodation)
  end

  def accommodation_params
    params.require(:accommodation).permit(:start_date, :end_date, :status, :reference_number, :number_of_nights, :participation_id, :address, :name, :photo, :phone_number, :url, :email, :total_price, :number_of_rooms)
  end
end
