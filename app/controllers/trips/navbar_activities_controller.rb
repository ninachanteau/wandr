class Trips::NavbarActivitiesController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
    @participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
    @avatar = current_user.avatar
    @activities = @trip.activities.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    url = @activity.url
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    name_array = doc.search('#HEADING').map { |element| element.text.strip.to_s }
    @activity.name = name_array[0] if name_array[0].present?
    street_array = doc.search('.street-address').map { |element| element.text.strip.to_s }
    city_array = doc.search('.locality').map { |element| element.text.strip.to_s }
    # country_array = doc.search('.country-name').map { |element| element.text.strip.to_s }
    # +" "+country_array[0]
    @activity.address = street_array[0]+","+city_array[0] if street_array[0].present? && city_array[0]
    description_array = doc.search('.additional_info .content').map { |element| element.text.strip.to_s }
    @activity.description = description_array.last if description_array.last.present?
    phone_array = doc.search('.blEntry span').map { |element| element.text.strip.to_s }
    @activity.status = "Wishlist"
    @activity.phone_number = phone_array[5] if phone_array[5].present?
    img_array = doc.search('.page_images img').map{ |i| i['src'] }
    @trips = current_user.trips.map {|trip| ["#{trip.destination} - #{trip.name}", trip.id]}
    if params[:trip_id].present?
      @trip = Trip.find(params[:trip_id])
      @activity.trip = @trip
      @trip_participants =  @trip.participations
    @act_participants = @trip_participants.select { |part| part if params[part.pseudo] == "1"}
    end
    if @activity.save
       respond_to do |format|
        format.html { redirect_to edit_trips_navbar_activity_path(@activity) }
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
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if request.referrer.include?('trips')
      @activity.update(activity_params)
      params[:activity][:participations][:pseudo].each do |part|
        @activ_participants << Participation.find(part) if part.present?
      end
      @activ_participants = []
      @activ_participants.each do |part|
        @activity.add_participant(part)
      end
      respond_to do |format|
        format.html { redirect_to trip_activities_path }
        format.js  # <-- idem
      end
      @trip = @activity.trip
      @current_participation = Participation.where(trip_id: @trip.id, user_id: current_user.id).first
      @my_activities = @current_participation.activities
      @all_reservations = Activity.where(trip_id: @trip.id)
      @all_activities = []
      @trip.all_activities.each do |key, _value|
        @all_activities << @all_reservations.where(name:key[0], date: key[1]).first unless @all_reservations.where(name:key[0], date: key[1]).nil?
      end
      @activities_unsorted = @all_activities.reject { |resa| resa unless (resa.same_reservation & @my_activities).empty? }
      @activities = @activities_unsorted.select(&:date).sort_by(&:date) + @activities_unsorted.reject(&:date)
    else
      @trip = params["activity"]["trip"]
      @activity.trip = Trip.find(@trip)
      @activity.update(activity_params)
      redirect_to root_path
    end
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:start_time, :date, :status, :participation_id, :address, :name, :photo, :phone_number, :description, :url, :email)
  end

end
