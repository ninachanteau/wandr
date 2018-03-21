class Accommodation < ApplicationRecord
  belongs_to :participation, optional: true
  belongs_to :trip, optional: true
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def add_participant(participant)
    @accommodation = Accommodation.new
    @accommodation.start_date = self.start_date
    @accommodation.end_date = self.end_date
    @accommodation.reference_number = self.reference_number
    @accommodation.number_of_nights = self.number_of_nights
    @accommodation.number_of_rooms = self.number_of_rooms
    @accommodation.status = self.status
    @accommodation.address = self.address
    @accommodation.name = self.name
    @accommodation.photo = self.photo
    @accommodation.phone_number = self.phone_number
    @accommodation.url = self.url
    @accommodation.email = self.email
    @accommodation.participation = participant
    @accommodation.latitude = self.latitude
    @accommodation.longitude = self.longitude
    @accommodation.total_price = self.total_price
    @accommodation.trip = self.trip
    @accommodation.save
  end

  def same_reservation
    same_resa =Accommodation.all.where(
      start_date: self.start_date,
      end_date: self.end_date,
      reference_number: self.reference_number,
      address: self.address,
      name: self.name,
      phone_number: self.phone_number,
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
