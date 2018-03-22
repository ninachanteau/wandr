require "open-uri"
require "nokogiri"

class ActivitiesController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @activities = Activity.where(trip_id: @trip.id)
    @activity = Activity.new
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.new
  end

  def create
    @activity = Activity.create(activity_params)
    @trip = Trip.find(params[:trip_id])
    @activity.trip = @trip
    # url = @activity.url
    # html_content = open(url).read
    # doc = Nokogiri::HTML(html_content)
    # name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    # @activity.name = name_array[0] if name_array[0].present?
    # street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    # city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # # +" "+country_array[0]
    # @activity.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    # description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    # @activity.description = description_array.last if description_array.last.present?
    # phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    # @activity.phone_number = phone_array[5] if phone_array[5].present?
    # img_array = doc.search('.page_images img').map{ |i| i['src'] }
    # @activity.remote_photo_url = img_array[1] if img_array[1].present?
    # @activity.trip = Trip.find(params[:trip_id]) if params[:trip_id].present?
    if @activity.save!
      redirect_to trip_activities_path(@trip)
      # if Activity.where(@activity.name).where(@activity.trip).count > 1
      #   redirect_to trip_activities
       # end
    else
      render 'new'
    end
  end

  def edit
    # @current_user = current_user
    # @trips = @current_user.trips.map {|trip| trip.name}
    @activity = Activity.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.find(params[:id])
    @activity = Activity.find(params[:id])
    @activity.update(status: params[:status])
    redirect_to trip_activities_path(@trip)
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to trip_activities_path(@trip)
  end


  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end

