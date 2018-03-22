require "open-uri"
require "nokogiri"

class AccommodationsController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @accommodations = Accommodation.where(trip_id: @trip.id)
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
    # url = @accommodation.url
    # html_content = open(url).read
    # doc = Nokogiri::HTML(html_content)
    # name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    # @accommodation.name = name_array[0] if name_array[0].present?
    # street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    # city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # # +" "+country_array[0]
    # @accommodation.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    # phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    # @accommodation.phone_number = phone_array[5] if phone_array[5].present?
    # img_array = doc.search('.page_images img').map{ |i| i['src'] }
    # @accommodation.remote_photo_url = img_array[1] if img_array[1].present?
    # @accommodation.number_of_nights = (@accommodation.end_date - @accommodation.start_date).to_i if @accommodation.end_date.present? && @accommodation.start_date.present?
    # @accommodation.trip = Trip.find(params[:trip_id]) if params[:trip_id].present?
    if @accommodation.save!
      # if Accommodation.where(@accommodation.name).where(@accommodation.trip).count > 1
      #   redirect_to trip_accommodations
      # else
      redirect_to trip_accommodations_path(@trip, @accommodation)
      # end
    else
      render 'new'
    end
  end

  def edit
    @current_user = current_user
    @trips = @current_user.trips.map {|trip| trip.name}

    @accommodation = Accommodation.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @accommodation = Accommodation.find(params[:id])
    @accommodation.update(status: params[:status])
    redirect_to trip_accommodations_path(@trip, @accommodation)
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
