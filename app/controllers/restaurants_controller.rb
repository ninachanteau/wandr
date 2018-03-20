require "open-uri"
require "nokogiri"

class RestaurantsController < ApplicationController


  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    url = @restaurant.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    @restaurant.name = name_array[0]
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    @restaurant.address = street_array[0]+","+city_array[0]+" "+country_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    @restaurant.description = description_array.last
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @restaurant.phone_number = phone_array[5]
    if @restaurant.save
      redirect_to edit_restaurant_path(@restaurant)
    else
      render 'trips/index'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    redirect_to root_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(@restaurant)
  end

  def restaurant_params
    params.require(:restaurant).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end
end

