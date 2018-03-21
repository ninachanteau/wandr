class Restaurant < ApplicationRecord
  belongs_to :participation, optional: true
  belongs_to :trip, optional: true
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
    @restaurant.trip = self.trip
    @restaurant.save
  end

  def same_reservation
    same_resa = Restaurant.where(
      start_time: self.start_time,
      date: self.date,
      status: self.status,
      address: self.address,
      name: self.name,
      phone_number: self.phone_number,
      description: self.description,
      trip: self.trip,
      )
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
end
