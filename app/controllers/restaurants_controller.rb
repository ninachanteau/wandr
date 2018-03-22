require "open-uri"
require "nokogiri"

class RestaurantsController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    # @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    # @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    # @avatar = current_user.avatar
    @my_restaurants = @current_participation.restaurants
    @restaurants = Restaurant.where(trip_id: @trip.id).reject {|resto| resto if resto.participation == @current_participation}
    @restaurant = Restaurant.new
  end

  def new
    @restaurant = Restaurant.new
    @trip = Trip.find(params[:trip_id])
    @restaurant.trip = @trip
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @trip = Trip.find(params[:trip_id])
    @restaurant.trip = @trip
    @trip_participants =  @trip.participations
    @resto_participants = @trip_participants.select { |part| part if params[part.pseudo.to_sym] == "on"}
    if @restaurant.save!
      @resto_participants.each do |part|
        @restaurant.add_participant(part)
      end
        redirect_to trip_restaurants_path(@trip)
    else
      render 'new'
    end
  end

  def edit
    # @current_user = current_user
    # @trips = @current_user.trips.map {|trip| trip.name}
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(status: params[:status])
    redirect_to trip_restaurants_path(@trip)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to trip_restaurants_path(@trip)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(@restaurant)
  end

  def restaurant_params
    params.require(:restaurant).permit(:date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end
end

