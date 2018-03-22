require "open-uri"
require "nokogiri"

class Transportations::UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.find_by_token(params[:token])
    @avatar = @current_participation.avatar
    @transportations = @trip.transportations.all
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @transportation = Transportation.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @transportation = Transportation.new(transpo_params)
    @current_participation = Participation.find_by_token(params[:token])
    @transportation.participation = @current_participation
    @transportation.save!
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
