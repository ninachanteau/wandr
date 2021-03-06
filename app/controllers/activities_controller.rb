require "open-uri"
require "nokogiri"

class ActivitiesController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @my_activities_unsorted = @current_participation.activities
    @my_activities = @my_activities_unsorted.select(&:date).sort_by(&:date) + @my_activities_unsorted.reject(&:date)
    @trip_participants =  @trip.participations
    @all_reservations = Activity.where(trip_id: @trip.id)
    @all_activities = []
    @trip.all_activities.each do |key, _value|
      @all_activities << @all_reservations.where(name:key[0], date: key[1]).first unless @all_reservations.where(name:key[0], date: key[1]).nil?
    end
    @activities_unsorted = @all_activities.reject { |resa| resa unless (resa.same_reservation & @my_activities).empty? }
    @activities = @activities_unsorted.select(&:date).sort_by(&:date) + @activities_unsorted.reject(&:date)
    #session[:notifications][:activity] = Time.now
    @activity = Activity.new
    @trip_dates = {
      start_date: @trip.start_date,
      end_date: @trip.end_date
    }
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
    @activity.same_reservation.each do |resa|
      resa.update(status: params[:status])
    end
    respond_to do |format|
      format.html { redirect_to trip_activities_path(@trip) }
      format.js
    end
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.find(params[:id])
    @activity.same_reservation.each { |resa| resa.destroy }
    # @activity.destroy
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

