require "open-uri"
require "nokogiri"

class RestaurantsController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    # @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    # @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    # @avatar = current_user.avatar
    @restaurants = Restaurant.where(trip_id: @trip.id)
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
    # url = @restaurant.url
    # html_content = open(url).read
    # doc = Nokogiri::HTML(html_content)
    # name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    # @restaurant.name = name_array[0] if name_array[0].present?
    # street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    # city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # # +" "+country_array[0]
    # @restaurant.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    # description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    # @restaurant.description = description_array.last if description_array.last.present?
    # phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    # @restaurant.phone_number = phone_array[5] if phone_array[5].present?
    # img_array = doc.search('.page_images img').map{ |i| i['src'] }
    # @restaurant.remote_photo_url = img_array[1] if img_array[1].present?
    # @restaurant.trip = Trip.find(params[:trip_id]) if params[:trip_id].present?
    if @restaurant.save!
      # if Restaurant.where(name: name_array[0]) == []
        redirect_to trip_restaurants_path(@trip, @restaurant)
      # elsif  Restaurant.where(name: @restaurant.name).where(trip_id: @restaurant.trip.id).count > 1
      #   redirect_to trip_restaurants
      # end
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
    redirect_to trip_restaurants_path(@trip, @restaurant)
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

