class Activity < ApplicationRecord
  belongs_to :participation, optional: true
  belongs_to :trip, optional: true
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def add_participant(participant)
    @activity = Activity.new
    @activity.start_time = self.start_time
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
    @activity.save
  end

  def count_participants
    same_resa =Activity.all.where(
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
