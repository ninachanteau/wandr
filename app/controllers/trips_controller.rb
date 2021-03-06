# require 'icalendar'

class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: :calendar

  def index
    @restaurant = Restaurant.new
    @accommodation = Accommodation.new
    @activity = Activity.new
    @future_trips = current_user.trips.future
    @past_trips = current_user.trips.past
    @wishlist_trips = current_user.trips.wishlist
    @trip = Trip.new
    respond_to do |format|
      format.html
      format.js
    end
    unless session[:notifications]
      session[:notifications] = {}
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @markers = []
    @events = []


    @transportations = @current_participation.transportations.select { |transportation| transportation unless transportation.departure_port_latitude == nil || transportation.departure_port_longitude == nil || transportation.arrival_port_latitude == nil || transportation.arrival_port_longitude == nil }
    unless @transportations.nil?
      @transportations.map do |transportation|
        if transportation.status == "Booked"
          @markers << {
            lat: transportation.departure_port_latitude,
            lng: transportation.departure_port_longitude,
            icon: {
              url: view_context.image_path('departure-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/transportations/map_box", locals: { transportation: transportation }) }
          }
          @markers << {
            lat: transportation.arrival_port_latitude,
            lng: transportation.arrival_port_longitude,
            icon: {
              url: view_context.image_path('arrival-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/transportations/map_box", locals: { transportation: transportation }) }
          }
          @events << {
            color: "#AAAAAA",
            title: "Transportation",
            start: transportation.departure_date,
            end: transportation.arrival_date
          }
        end
      end
    end

    @accommodations = @current_participation.accommodations.select { |accommodation| accommodation unless accommodation.latitude == nil || accommodation.longitude == nil }
    unless @accommodations.nil?
      @accommodations.map do |accommodation|
        if accommodation.status == "Booked"
          @markers << {
            lat: accommodation.latitude,
            lng: accommodation.longitude,
            icon: {
              url: view_context.image_path('accommodation-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/accommodations/map_box", locals: { accommodation: accommodation }) }
          }
          @events << {
            color: "#AAAAAA",
            title: accommodation.name,
            start: accommodation.start_date,
            end: accommodation.end_date,
            allDay: true
          }
        elsif accommodation.status == "Wishlist"
          @markers << {
            lat: accommodation.latitude,
            lng: accommodation.longitude,
            icon: {
              url: view_context.image_path('accommodation.svg')
            },
            infoWindow: { content: render_to_string(partial: "/accommodations/map_box", locals: { accommodation: accommodation }) }
          }
        end
      end
    end

    @restaurants = @current_participation.restaurants.select { |restaurant| restaurant unless restaurant.latitude == nil || restaurant.longitude == nil }
    unless @restaurants.nil?
      # @restaurant_markers =
      @restaurants.map do |restaurant|
        if restaurant.status == "Booked"
          @markers << {
            lat: restaurant.latitude,
            lng: restaurant.longitude,
            icon: {
              url: view_context.image_path('restaurant-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/restaurants/map_box", locals: { restaurant: restaurant }) }
          }
          @events << {
            color: "#AAAAAA",
            title: restaurant.name,
            start: restaurant.date
          }
        elsif restaurant.status == "Wishlist"
          @markers << {
            lat: restaurant.latitude,
            lng: restaurant.longitude,
            icon: {
              url: view_context.image_path('restaurant.svg')
            },
            infoWindow: { content: render_to_string(partial: "/restaurants/map_box", locals: { restaurant: restaurant }) }
          }
        end
      end
    end

    @activities = @current_participation.activities.select { |activity| activity unless activity.latitude == nil || activity.longitude == nil }
    unless @activities.nil?
      # @activity_markers =
      @activities.map do |activity|
        if activity.status == "Booked"
          @markers << {
            lat: activity.latitude,
            lng: activity.longitude,
            icon: {
              url: view_context.image_path('activity-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/activities/map_box", locals: { activity: activity }) }
          }
          @events << {
            color: "#AAAAAA",
            title: activity.name,
            start: activity.date
          }
        elsif activity.status == "Wishlist"
          @markers << {
            lat: activity.latitude,
            lng: activity.longitude,
            icon: {
              url: view_context.image_path('activity.svg')
            },
            infoWindow: { content: render_to_string(partial: "/activities/map_box", locals: { activity: activity }) }
          }
        end
      end
    end

    @events = @events.sort_by { |event| event[:start] }
    @participation = Participation.new
    @participation.trip = @trip

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @participation = Participation.new
      @participation.user = current_user
      @participation.trip = @trip
      @participation.avatar = current_user.avatar.url
      @participation.pseudo = current_user.first_name
      @participation.save
      @trip.save
      redirect_to trips_path
    else
      render :new
    end
  end

  def add_participant
    @participation = Participation.new
    @participation.trip = Trip.find(params[:id])
    redirect_to trip_participations(@participation.trip)
  end

  def recap
    @trip = Trip.find(params[:id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first

    @transportations_unsorted = @current_participation.transportations.select { |transpo| transpo if transpo.status == "Booked" }
    @transportations = @transportations_unsorted.sort_by { |transpo| transpo.departure_date}
    @accommodations_unsorted = @current_participation.accommodations.select { |accommo| accommo if accommo.status == "Booked" }
    @accommodations = @accommodations_unsorted.sort_by { |accommo| accommo.start_date}
    @restaurants_unsorted = @current_participation.restaurants.select { |resto| resto if resto.status == "Booked" }
    @restaurants = @restaurants_unsorted.sort_by { |resto| resto.date}
    @activities_unsorted = @current_participation.activities.select { |activity| activity if activity.status == "Booked" }
    @activities = @activities_unsorted.sort_by { |activity| activity.date}

    @wishlist_accommodations = @current_participation.accommodations.select { |accommo| accommo if accommo.status == "Wishlist" }
    @wishlist_restaurants = @current_participation.restaurants.select { |resto| resto if resto.status == "Wishlist" }
    @wishlist_activities = @current_participation.activities.select { |activity| activity if activity.status == "Wishlist" }

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "recap", disposition: "attachment"
      end
    end
  end

  def calendar
    @trip = Trip.find(params[:id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: params[:user_id]).first
    @events = []

    @transportations = @current_participation.transportations.select { |transportation| transportation unless transportation.departure_port_latitude == nil || transportation.departure_port_longitude == nil || transportation.arrival_port_latitude == nil || transportation.arrival_port_longitude == nil }
    unless @transportations.nil?
      @transportations.map do |transportation|
        if transportation.status == "Booked"
          @events << {
            title: "Transportation",
            start: transportation.departure_date,
            end: transportation.arrival_date,
            address: transportation.departure_port,
          }
        end
      end
    end

    @accommodations = @current_participation.accommodations.select { |accommodation| accommodation unless accommodation.latitude == nil || accommodation.longitude == nil }
    unless @accommodations.nil?
      @accommodations.map do |accommodation|
        if accommodation.status == "Booked"
          @events << {
            title: accommodation.name,
            start: accommodation.start_date,
            end: accommodation.end_date,
            address: accommodation.address
          }
        end
      end
    end

    @restaurants = @current_participation.restaurants.select { |restaurant| restaurant unless restaurant.latitude == nil || restaurant.longitude == nil }
    unless @restaurants.nil?
      @restaurants.map do |restaurant|
        if restaurant.status == "Booked"
          @events << {
            title: restaurant.name,
            start: restaurant.date,
            address: restaurant.address
          }
        end
      end
    end

    @activities = @current_participation.activities.select { |activity| activity unless activity.latitude == nil || activity.longitude == nil }
    unless @activities.nil?
      @activities.map do |activity|
        if activity.status == "Booked"
          @events << {
            title: activity.name,
            start: activity.date,
            address: activity.address
          }
        end
      end
    end

    cal = Icalendar::Calendar.new
    cal.append_custom_property("NAME","#{@trip.destination} - Wandr")
    cal.append_custom_property("X-WR-CALNAME","#{@trip.destination} - Wandr")
    @events.each do |event|
      cal_event = Icalendar::Event.new
      cal_event.dtstart = event[:start]
      cal_event.dtend = event[:end]
      cal_event.summary = event[:title]
      cal.add_event(cal_event)
    end
    cal.publish
    render plain: cal.to_ical, content_type: 'text/plain'
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :photo, :start_date, :end_date, :description, :name)
  end

end
