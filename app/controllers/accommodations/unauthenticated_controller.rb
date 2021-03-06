require "open-uri"
require "nokogiri"

class Accommodations::UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.find_by_token(params[:token])
    @avatar = @current_participation.avatar
    @accommodation = @trip.accommodation.all
  end

  def new
    @accommodation = Accommodation.new
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    url = @accommodation.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    @accommodation.name = name_array[0] if name_array[0].present?
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # +" "+country_array[0]
    @accommodation.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @accommodation.phone_number = phone_array[5] if phone_array[5].present?
    img_array = doc.search('.page_images img').map{ |i| i['src'] }
    @accommodation.remote_photo_url = img_array[1] if img_array[1].present?
    @accommodation.number_of_nights = (@accommodation.end_date - @accommodation.start_date).to_i if @accommodation.end_date.present? && @accommodation.start_date.present?
    @accommodation.trip = Trip.find(params[:trip_id]) if params[:trip_id].present?
    if @acommodation.save
      # if Accommodation.where(@accommodation.name).where(@accommodation.trip).count > 1
      #   redirect_to trip_accommodations
      # else
      redirect_to edit_accommodation_path(@accommodation)
      # end
    else
      render 'trips/index'
    end
  end

  def edit
    @current_participation = Participation.find_by_token(params[:token])
    @accommodation = Accommodation.find(params[:id])
  end

  def update
    @accommodation = Accommodation.find(params[:id])
    @current_participation = Participation.find_by_token(params[:token])
    @accommodation.trip = @current_participation.trip unless @accommodation.trip.present?
    redirect_to root_path
  end

  private

  def set_accommodation
    @accommodation = Accommodation.find(@accommodation)
  end

  def accommodation_params
    params.require(:accommodation).permit(:start_date, :end_date, :status, :reference_number, :number_of_nights, :participation_id, :address, :name, :photo, :phone_number, :url, :email, :total_price, :number_of_rooms)
  end

end
