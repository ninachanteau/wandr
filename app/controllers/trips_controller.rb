class TripsController < ApplicationController

  def index
    @restaurant = Restaurant.new
    @accommodation = Accommodation.new
    @activity = Activity.new
    @future_trips = current_user.trips.future
    @past_trips = current_user.trips.past
    @wishlist_trips = current_user.trips.wishlist
    @trip = Trip.new
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
            infoWindow: { content: render_to_string(partial: "/transportations/map_box_departure", locals: { transportation: transportation }) }
          }
          @markers << {
            lat: transportation.arrival_port_latitude,
            lng: transportation.arrival_port_longitude,
            icon: {
              url: view_context.image_path('arrival-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/transportations/map_box_arrival", locals: { transportation: transportation }) }
          }
          @events << {
            color: "#FFC61B",
            title: "Transportation",
            start: transportation.departure_date,
            end: transportation.arrival_date,
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
            infoWindow: { content: render_to_string(partial: "/accommodations/map_box_booked", locals: { accommodation: accommodation }) }
          }
          @events << {
            color: "#FFDD75",
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
            infoWindow: { content: render_to_string(partial: "/accommodations/map_box_wishlist", locals: { accommodation: accommodation }) }
          }
        end
      end
    end

    @restaurants = @current_participation.restaurants.select { |restaurant| restaurant unless restaurant.latitude == nil || restaurant.longitude == nil }
    unless @restaurants.nil?
      @restaurant_markers = @restaurants.map do |restaurant|
        if restaurant.status == "Booked"
          @markers << {
            lat: restaurant.latitude,
            lng: restaurant.longitude,
            icon: {
              url: view_context.image_path('restaurant-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/restaurants/map_box_booked", locals: { restaurant: restaurant }) }
          }
          @events << {
            color: "#FFDD75",
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
            infoWindow: { content: render_to_string(partial: "/restaurants/map_box_wishlist", locals: { restaurant: restaurant }) }
          }
        end
      end
    end

    @activities = @current_participation.activities.select { |activity| activity unless activity.latitude == nil || activity.longitude == nil }
    unless @activities.nil?
      @activity_markers = @activities.map do |activity|
        if activity.status == "Booked"
          @markers << {
            lat: activity.latitude,
            lng: activity.longitude,
            icon: {
              url: view_context.image_path('activity-yellow.svg')
            },
            infoWindow: { content: render_to_string(partial: "/activities/map_box_booked", locals: { activity: activity }) }
          }
          @events << {
            color: "#FFDD75",
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
            infoWindow: { content: render_to_string(partial: "/activities/map_box_wishlist", locals: { activity: activity }) }
          }
        end
      end
    end

    @participation = Participation.new
    @participation.trip = @trip
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
    redirect_to trip_partipations(@participation.trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :photo, :start_date, :end_date, :description, :name)
  end

end
