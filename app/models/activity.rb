class Activity < ApplicationRecord
  belongs_to :participation, optional: true
  delegate :trip, to: :participation
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
    @activity.trip = self.trip
    @activity.save
  end
end
