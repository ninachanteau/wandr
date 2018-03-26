class Trips::UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @current_participation = Participation.find_by_token(params[:id])
    @trip = @current_participation.trip
    @markers = []
    @events = []
    @transportations = @current_participation.transportations.select { |transportation| transportation unless transportation.departure_port_latitude == nil || transportation.departure_port_longitude == nil || transportation.arrival_port_latitude == nil || transportation.arrival_port_longitude == nil }
    unless @transportations.nil?
      @transportations.map do |transportation|
        if transportation.status == "Booked"
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
          @events << {
            color: "#FFC61B",
            title: "Transportation",
            start: transportation.departure_date,
            end: transportation.arrival_date,
          }
        end
      end
    end

    @accomodations = @current_participation.accommodations.select { |accommodation| accommodation unless accommodation.latitude == nil || accommodation.longitude == nil }
    unless @accommodations.nil?
      @accommodations.map do |accommodation|
        if accommodation.status == "Booked"
          @markers << {
            lat: accommodation.latitude,
            lng: accommodation.longitude#,
            #icon:
            # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          }
          @events << {
            color: "#FFDD75",
            title: accommodation.name,
            start: accommodation.start_date
          }
        elsif accommodation.status == "Wishlist"
          @markers << {
            lat: accommodation.latitude,
            lng: accommodation.longitude#,
            #icon:
            # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
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
            lng: restaurant.longitude#,
            #icon:
            # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          }
          @events << {
            title: restaurant.name,
            start: restaurant.date
          }
        elsif restaurant.status == "Wishlist"
          @markers << {
            lat: restaurant.latitude,
            lng: restaurant.longitude#,
            #icon:
            # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
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
            lng: activity.longitude#,
            #icon:
            # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          }
          @events << {
            title: activity.name,
            start: activity.date
          }
        elsif activity.status == "Wishlist"
          @markers << {
            lat: activity.latitude,
            lng: activity.longitude#,
            #icon:
            # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          }
        end
      end
    end

    @participation = Participation.new
    @participation.trip = @trip
    render 'trips/show'
  end

  def add_participant
    @trip = Trip.find(params[:id])
    @participation = Participation.new
    @participation.trip = @trip
    redirect_to trip_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :photo, :start_date, :end_date, :description, :name)
  end
end
