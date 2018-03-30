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
    @restaurant.status = "Wishlist"
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
    if request.referrer.include?('trips')
      @resto_participants = []
      @restaurant.update(restaurant_params)
      params[:restaurant][:participations][:pseudo].each do |part|
        @resto_participants << Participation.find(part) if part.present?
      end
      @resto_participants.each do |part|
        @restaurant.add_participant(part)
      end
      @trip = Trip.find(params[:trip_id])
      @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
      @my_restaurants = @current_participation.restaurants
      @all_reservations = Restaurant.where(trip_id: @trip.id)
      @all_restaurants = []
      @trip.all_restaurants.each do |key, _value|
        @all_restaurants << @all_reservations.where(name:key[0], date: key[1]).first unless @all_reservations.where(name:key[0], date: key[1]).nil?
      end
      @restaurants_unsorted = @all_restaurants.reject { |resa| resa unless (resa.same_reservation & @my_restaurants).empty? }
      @restaurants = @restaurants_unsorted.select(&:date).sort_by(&:date) + @restaurants_unsorted.reject(&:date)
      respond_to do |format|
        format.html { redirect_to trip_restaurants_path }
        format.js  # <-- idem
      end
    else
      @trip = params["restaurant"]["trip"]
      @restaurant.trip = Trip.find(@trip)
      @restaurant.update(restaurant_params)
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
