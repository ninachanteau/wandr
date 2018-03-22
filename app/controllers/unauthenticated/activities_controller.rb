require "open-uri"
require "nokogiri"

class Unauthenticated::ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.find_by_token(params[:token])
    @avatar = @current_participation.avatar
    @activities = @trip.activities.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    url = @activity.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    @activity.name = name_array[0] if name_array[0].present?
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # +" "+country_array[0]
    @activity.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    @activity.description = description_array.last if description_array.last.present?
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @activity.phone_number = phone_array[5] if phone_array[5].present?
    img_array = doc.search('.page_images img').map{ |i| i['src'] }
    @activity.remote_photo_url = img_array[1] if img_array[1].present?
    @activity.trip = Trip.find(params[:trip_id]) if params[:trip_id].present?
    if @activity.save
      # if Activity.where(@activity.name).where(@activity.trip).count > 1
      #   redirect_to trip_activities
       # end
    else
      render 'trips/index'
    end
  end

  def edit
    @current_participation = Participation.find_by_token(params[:token])
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    @current_participation = Participation.find_by_token(params[:token])
    @activity.trip = @current_participation.trip unless @activity.trip.present?
    redirect_to root_path
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end

end
