require "open-uri"
require "nokogiri"

class Restaurants::UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.find_by_token(params[:token])
    @avatar = @current_participation.avatar
    @restaurants = @trip.restaurants.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    url = @restaurant.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    @restaurant.name = name_array[0] if name_array[0].present?
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # +" "+country_array[0]
    @restaurant.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    @restaurant.description = description_array.last if description_array.last.present?
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @restaurant.phone_number = phone_array[5] if phone_array[5].present?
    img_array = doc.search('.page_images img').map{ |i| i['src'] }
    @restaurant.remote_photo_url = img_array[1] if img_array[1].present?
    @restaurant.trip = Trip.find(params[:trip_id]) if params[:trip_id].present?
    if @restaurant.save
      # if Restaurant.where(name: name_array[0]) == []
        redirect_to edit_restaurant_path(@restaurant)
      # elsif  Restaurant.where(name: @restaurant.name).where(trip_id: @restaurant.trip.id).count > 1
      #   redirect_to trip_restaurants
      # end
    else
      render 'trips/index'
    end
  end

  def edit
    @current_participation = Participation.find_by_token(params[:token])
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @current_participation = Participation.find_by_token(params[:token])
    @restaurant.trip = @current_participation.trip unless @restaurant.trip.present?
    redirect_to root_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(@restaurant)
  end

  def restaurant_params
    params.require(:restaurant).permit(:date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end
