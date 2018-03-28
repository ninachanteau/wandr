class Activity < ApplicationRecord
  belongs_to :participation, optional: true
  belongs_to :trip, optional: true
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def add_participant(participant)
    @activity = Activity.new
    @activity.date = self.date
    @activity.status = self.status
    @activity.address = self.address
    @activity.name = self.name
    @activity.photo = self.photo
    @activity.phone_number = self.phone_number
    @activity.description = self.description
    @activity.url = self.url
    @activity.email = self.email
    @activity.participation = participant
    @activity.latitude = self.latitude
    @activity.longitude = self.longitude
    @activity.trip = self.trip
    @activity.save
  end

  def same_reservation
    same_resa =Activity.all.where(
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
      participants << instance.participation unless instance.participation.nil?
    end
    return participants
  end
end
