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

    @accomodations = @trip.accommodations.select { |accommodation| accommodation unless accommodation.latitude == nil || accommodation.longitude == nil }
    unless @accommodations.nil?
      @accommodation_markers = @accommodations.map do |accommodation|
        {
          lat: accommodation.latitude,
          lng: accommodation.longitude#,
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
      end
    end
    @restaurants = @trip.restaurants.select { |restaurant| restaurant unless restaurant.latitude == nil || restaurant.longitude == nil }
    unless @restaurants.nil?
      @restaurant_markers = @restaurants.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude#,
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
      end
    end
    @activities = @trip.activities.select { |activity| activity unless activity.latitude == nil || activity.longitude == nil }
    unless @activities.nil?
      @activity_markers = @activities.map do |activity|
        {
          lat: activity.latitude,
          lng: activity.longitude#,
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        }
      end
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
      @participation.save
      redirect_to trips_path
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :photo, :start_date, :end_date, :description, :name)
  end

end
