class Trips::NavbarRestaurantsController < ApplicationController

  def new
    @restaurant = Restaurant.new
    @trip = Trip.find(params[:trip_id])
    @restaurant.trip = @trip
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    url = @restaurant.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('#HEADING').map { |element| element.text.strip.to_s }
    @restaurant.name = name_array[0] if name_array[0].present?
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # +" "+country_array[0]
    @restaurant.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @restaurant.phone_number = phone_array[5] if phone_array[5].present?
    @trips =  current_user.trips.map {|trip| ["#{trip.destination} - #{trip.name}", trip.id]}
    if params[:trip_id].present?
    @trip = Trip.find(params[:trip_id])
    @restaurant.trip = @trip
    end
    if @restaurant.save
       respond_to do |format|
        format.html { redirect_to edit_trips_navbar_restaurant_path(@restaurant) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'trips/index' }
        format.js  # <-- idem
      end
    end
  end

  def edit
    @current_user = current_user
    @trips = @current_user.trips.map {|trip| trip.name}
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    unless @restaurant.trip
      @trip = params["restaurant"]["trip"]
      @restaurant.trip = Trip.find(@trip)
    end
    @restaurant.update(restaurant_params)
    @accom_participants = []
    if params[:restaurant][:participations]
      if params[:restaurant][:participations][:pseudo]
        params[:restaurant][:participations][:pseudo].each do |part|
          @accom_participants << Participation.find(part) if part.present?
        end
        @accom_participants.each do |part|
          @restaurant.add_participant(part)
        end
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(@restaurant)
  end

  def restaurant_params
    params.require(:restaurant).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end
