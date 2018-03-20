require "open-uri"
require "nokogiri"

class AccommodationsController < ApplicationController

  def new
    @accommodation = Accommodation.new
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    url = @accommodation.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    @accommodation.name = name_array[0]
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    @accommodation.address = street_array[0]+","+city_array[0]+" "+country_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    @accommodation.description = description_array.last
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @accommodation.phone_number = phone_array[5]
    if @accommodation.save
      redirect_to edit_accommodation_path(@accommodation)
    else
      render 'trips/index'
    end
  end

  def edit
    @accommodation = Accommodation.find(params[:id])
  end

  def update
    @accommodation = Accommodation.find(params[:id])
    redirect_to root_path
  end

  private

  def set_accommodation
    @accommodation = Accommodation.find(@accommodation)
  end

  def accommodation_params
    params.require(:accommodation).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end
end
