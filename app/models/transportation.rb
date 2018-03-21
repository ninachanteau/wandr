class Transportation < ApplicationRecord
  belongs_to :participation
  delegate :trip, to: :participation

  def add_participant(participant)
    @transportation = Transportation.new
    @transportation.departure_date = self.departure_date
    @transportation.arrival_date = self.arrival_date
    @transportation.departure_port = self.departure_port
    @transportation.arrival_port = self.arrival_port
    @transportation.departure_time = self.departure_time
    @transportation.arrival_time = self.arrival_time
    @transportation.reference_number = self.reference_number
    @transportation.status = self.status
    @transportation.latitude = self.latitude
    @transportation.longitude = self.longitude
    @transportation.save
  end

  def count_participants
    same_resa =Transportation.all.where(
      departure_date: self.departure_date,
      departure_port: self.departure_port,
      departure_time: self.departure_time,
      arrival_date: self.arrival_date,
      arrival_port: self.arrival_port,
      arrival_time: self.arrival_time,
      status: self.status,
      )
    same_resa_trip = same_resa.select {|resa| resa.participation.trip == self.participation.trip }
    same_resa_trip.count
  end

end
