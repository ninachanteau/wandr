require "open-uri"
require "nokogiri"

class RestaurantsController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @my_restaurants_unsorted = @current_participation.restaurants
    @my_restaurants = @my_restaurants_unsorted.select(&:date).sort_by(&:date) + @my_restaurants_unsorted.reject(&:date)
    @all_reservations = Restaurant.where(trip_id: @trip.id)
    @all_restaurants = []
    @trip.all_restaurants.each do |key, _value|
      @all_restaurants << @all_reservations.where(name:key[0], date: key[1]).first unless @all_reservations.where(name:key[0], date: key[1]).nil?
    end
    @restaurants_unsorted = @all_restaurants.reject { |resa| resa unless (resa.same_reservation & @my_restaurants).empty? }
    @restaurants = @restaurants_unsorted.select(&:date).sort_by(&:date) + @restaurants_unsorted.reject(&:date)
    #session[:notifications][:restaurant] = Time.now
    @restaurant = Restaurant.new
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
    @restaurant = Restaurant.new
    @trip = Trip.find(params[:trip_id])
    @restaurant.trip = @trip
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @trip = Trip.find(params[:trip_id])
    @restaurant.trip = @trip
    @trip_participants =  @trip.participations
    @resto_participants = @trip_participants.select { |part| part if params[part.pseudo] == "1"}
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
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @restaurant = Restaurant.find(params[:id])
    @restaurant.same_reservation.each do |resa|
      resa.status = params[:status]
      resa.update(restaurant_params)
    end
    respond_to do |format|
      format.html { redirect_to trip_restaurants_path(@trip) }
      format.js
    end
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @restaurant = Restaurant.find(params[:id])
    @restaurant.same_reservation.each { |resa| resa.destroy }
    # @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to trip_restaurants_path(@trip) }
      format.js
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(@restaurant)
  end

  def restaurant_params
    params.require(:restaurant).permit(:date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end
end

