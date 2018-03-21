class Accommodation < ApplicationRecord
  belongs_to :participation, optional: true
  delegate :trip, to: :participation
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def add_participant(participant)
   @accommodation = Accommodation.new
   @accommodation.start_time = self.start_time
   @accommodation.date = self.date
   @accommodation.status = self.status
   @accommodation.address = self.address
   @accommodation.name = self.name
   @accommodation.photo = self.photo
   @accommodation.phone_number = self.phone_number
   @accommodation.description = self.description
   @accommodation.url = self.url
   @accommodation.email = self.email
   @accommodation.participation = participant
   @accommodation.trip = self.trip
   @accommodation.save
  end

end
