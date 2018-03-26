require "open-uri"
require "nokogiri"

class ActivitiesController < ApplicationController

  def index
    # @trip = Trip.find(params[:trip_id])
    # @activities = Activity.where(trip_id: @trip.id)
    # @activity = Activity.new
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @my_activities = @current_participation.activities
    @trip_participants =  @trip.participations
    @all_reservations = Activity.where(trip_id: @trip.id)
    @all_activities = []
    @trip.all_activities.each do |key, _value|
      @all_activities << @all_reservations.where(name:key[0], date: key[1]).first unless @all_reservations.where(name:key[0], date: key[1]).nil?
    end
    @activities = @all_activities.reject { |resa| resa unless (resa.same_reservation & @my_activities).empty? }
    @activity = Activity.new
    respond_to do |format|
      format.html
      format.js
    end
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
    @act_participants = @trip_participants.select { |part| part if params[part.pseudo] == "1"}
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

