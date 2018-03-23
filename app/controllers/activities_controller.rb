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
    @trip_participants =  @trip.participations
    @act_participants = @trip_participants.select { |part| part if params[part.pseudo.to_sym] == "on"}
    if @activity.save!
      @act_participants.each do |part|
        @activity.add_participant(part)
      end
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
    params.require(:activity).permit(:date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end

