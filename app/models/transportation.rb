class Transportation < ApplicationRecord
  belongs_to :participation
  delegate :trip, to: :participation
  geocoded_by :arrival_port, latitude: :arrival_port_latitude, longitude: :arrival_port_longitude
  geocoded_by :departure_port, latitude: :departure_port_latitude, longitude: :departure_port_longitude
  after_validation :geocode_location, if: :will_save_change_to_departure_port? || :will_save_change_to_arrival_port?

  def add_participant(participant)
    @transportation = Transportation.new
    @transportation.departure_date = self.departure_date
    @transportation.arrival_date = self.arrival_date
    @transportation.departure_port = self.departure_port
    @transportation.arrival_port = self.arrival_port
    @transportation.reference_number = self.reference_number
    @transportation.status = self.status
    @transportation.departure_port_latitude = self.departure_port_latitude
    @transportation.departure_port_longitude = self.departure_port_longitude
    @transportation.arrival_port_latitude = self.arrival_port_latitude
    @transportation.arrival_port_longitude = self.arrival_port_longitude
    @transportation.trip = self.trip
    @transportation.save
  end

  def same_reservation
    same_resa =Transportation.all.where(
      departure_date: self.departure_date,
      departure_port: self.departure_port,
      arrival_date: self.arrival_date,
      arrival_port: self.arrival_port,
      status: self.status,
      )
    same_resa_trip = same_resa.select {|resa| resa.participation.trip == self.participation.trip }
  end

  def count_participants
    self.same_reservation.count
  end

  def participants
    participants = []
    self.same_reservation.each do |instance|
      participants << instance.participation
    end
    return participants
  end

  private

  def geocode_location
    if departure_port_changed?
      departure_address = Geocoder.search(self.departure_port).first
      if departure_address
        self.departure_port_latitude = departure_address.latitude
        self.departure_port_longitude = departure_address.longitude
      end
    end

    if arrival_port_changed?
      arrival_address = Geocoder.search(self.arrival_port).first
      if arrival_address
        self.arrival_port_latitude = arrival_address.latitude
        self.arrival_port_longitude = arrival_address.longitude
      end
    end
  end

end
