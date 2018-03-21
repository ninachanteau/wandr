class Restaurant < ApplicationRecord
  belongs_to :participation, optional: true
  delegate :trip, to: :participation, allow_nil: true
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def add_participant(participant)
    @restaurant = Restaurant.new
    @restaurant.start_time = self.start_time
    @restaurant.date = self.date
    @restaurant.status = self.status
    @restaurant.address = self.address
    @restaurant.name = self.name
    @restaurant.photo = self.photo
    @restaurant.phone_number = self.phone_number
    @restaurant.description = self.description
    @restaurant.url = self.url
    @restaurant.email = self.email
    @restaurant.participation = participant
    @restaurant.latitude = self.latitude
    @restaurant.longitude = self.longitude
    @restaurant.save
  end

  def count_participants
    same_resa = Restaurant.where(
      start_time: self.start_time,
      date: self.date,
      status: self.status,
      address: self.address,
      name: self.name,
      phone_number: self.phone_number,
      description: self.description,
      )
    same_resa_trip = same_resa.select {|resa| resa.participation.trip == self.participation.trip }
    same_resa_trip.count
  end
end
