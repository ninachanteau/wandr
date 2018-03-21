class TripsController < ApplicationController

  def index
    @restaurant = Restaurant.new
    @accommodation = Accommodation.new
    @activity = Activity.new
    @future_trips = current_user.trips.future
    @past_trips = current_user.trips.past
    @wishlist_trips = current_user.trips.wishlist
  end

  def show
    @trip = Trip.find(params[:id])
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id)
    @markers = []
    @events = []
    @transportations = @trip.transportations.select { |transportation| transportation unless transportation.departure_port_latitude == nil || transportation.departure_port_longitude == nil || transportation.arrival_port_latitude == nil || transportation.arrival_port_longitude == nil }
    unless @transportations.nil?
      @transportations.map do |transportation|
        @markers << {
          lat: transportation.departure_port_latitude,
          lng: transportation.departure_port_longitude#,
          #icon:
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
        @markers << {
          lat: transportation.arrival_port_latitude,
          lng: transportation.arrival_port_longitude#,
          #icon:
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
        if transportation.status == "Booked"
          @events << {
            title: "Transportation",
            start: transportation.departure_date
          }
        end
      end
    end

    @accomodations = @trip.accommodations.select { |accommodation| accommodation unless accommodation.latitude == nil || accommodation.longitude == nil }
    unless @accommodations.nil?
      @accommodations.map do |accommodation|
        @markers << {
          lat: accommodation.latitude,
          lng: accommodation.longitude#,
          #icon:
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
        if accommodation.status == "Booked"
          @events << {
            title: accommodation.name,
            start: accommodation.start_date
          }
        end
      end
    end
    @restaurants = @trip.restaurants.select { |restaurant| restaurant unless restaurant.latitude == nil || restaurant.longitude == nil }
    unless @restaurants.nil?
      @restaurant_markers = @restaurants.map do |restaurant|
        @markers << {
          lat: restaurant.latitude,
          lng: restaurant.longitude#,
          #icon:
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
        if restaurant.status == "Booked"
          @events << {
            title: restaurant.name,
            start: restaurant.date
          }
        end
      end
    end
    @activities = @trip.activities.select { |activity| activity unless activity.latitude == nil || activity.longitude == nil }
    unless @activities.nil?
      @activity_markers = @activities.map do |activity|
        @markers << {
          lat: activity.latitude,
          lng: activity.longitude#,
          #icon:
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
        if activity.status == "Booked"
          @events << {
            title: activity.name,
            start: activity.date
          }
        end
      end
    end
    @participation = Participation.new
    @participation.trip = Trip.find(params[:id])
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
      @participation.save
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
