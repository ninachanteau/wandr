require "open-uri"
require "nokogiri"

class ActivitiesController < ApplicationController

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    url = @activity.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('.heading_title').map { |element| element.text.strip.to_s }
    @activity.name = name_array[0]
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    @activity.address = street_array[0]+","+city_array[0]+" "+country_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    @activity.description = description_array.last
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @activity.phone_number = phone_array[5]
    if @activity.save
      redirect_to edit_activity_path(@activity)
    else
      render 'trips/index'
    end
  end

  def

  private

  def set_activity
    @activity = Restaurant.find(@activity)
  end

  def activity_params
    params.require(:activity).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end
