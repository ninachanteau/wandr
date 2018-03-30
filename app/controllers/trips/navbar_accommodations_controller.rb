class Trips::NavbarAccommodationsController < ApplicationController
  def index
    @trip = Trip.find(params[:trip_id])
    @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @avatar = current_user.avatar
    @accommodations = @trip.accommodations.all
  end

  def new
    @accommodation = Accommodation.new
  end

  def create
    @accommodation = Accommodation.new(accommodation_params)
    url = @accommodation.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('#HEADING').map { |element| element.text.strip.to_s }
    @accommodation.name = name_array[0] if name_array[0].present?
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # +" "+country_array[0]
    @accommodation.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @accommodation.phone_number = phone_array[5] if phone_array[5].present?
    img_array = doc.search('.page_images img').map{ |i| i['src'] }
    @accommodation.status = "Wishlist"
    @accommodation.remote_photo_url = img_array[1] if img_array[1].present?
    @accommodation.number_of_nights = (@accommodation.end_date - @accommodation.start_date).to_i if @accommodation.end_date.present? && @accommodation.start_date.present?
    @trips = current_user.trips.map {|trip| ["#{trip.destination} - #{trip.name}", trip.id]}
    if params[:trip_id].present?
    @trip = Trip.find(params[:trip_id])
    @accommodation.trip = @trip
    end
    if @accommodation.save
       respond_to do |format|
        format.html { redirect_to edit_trips_navbar_accommodation_path(@accommodation) }
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
    @trips = @current_user.trips.map {|trip| [trip.name, trip.id]}
    @accommodation = Accommodation.find(params[:id])
  end

  def update
    @accommodation = Accommodation.find(params[:id])
    if request.referrer.include?('trips')
      @accommodation.update(accommodation_params)
      @trip = @accommodation.trip
      @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
      @my_accommodations = @current_participation.accommodations
      @all_reservations = Accommodation.where(trip_id: @trip.id)
      @all_accommodations = []
      @trip.all_accommodations.each do |key, _value|
        @all_accommodations << @all_reservations.where(name:key[0], start_date: key[1], end_date: key[2]).first unless @all_reservations.where(name:key[0], start_date: key[1], end_date: key[2]).nil?
      end
      @accommodations_unsorted = @all_accommodations.reject { |resa| resa unless (resa.same_reservation & @my_accommodations).empty? }
      @accommodations = @accommodations_unsorted.select(&:start_date).sort_by(&:start_date) + @accommodations_unsorted.reject(&:start_date)
      @accom_participants = []
      params[:accommodation][:participations][:pseudo].each do |part|
        @accom_participants << Participation.find(part) if part.present?
      end
      @accom_participants.each do |part|
        @accommodation.add_participant(part)
      end
      respond_to do |format|
        format.html { redirect_to  trip_accommodations_path }
        format.js  # <-- idem
      end
    else
      @trip = params["accommodation"]["trip"]
      @accommodation.trip = Trip.find(@trip)
      @accommodation.update(accommodation_params)
      redirect_to root_path
    end
  end

  private

  def set_accommodation
    @accommodation = Accommodation.find(@accommodation)
  end

  def accommodation_params
    params.require(:accommodation).permit(:start_date, :end_date, :status, :reference_number, :number_of_nights, :participation_id, :address, :name, :photo, :phone_number, :url, :email, :total_price, :number_of_rooms, :trip_id)
  end

end
