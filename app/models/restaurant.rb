class Restaurant < ApplicationRecord
  belongs_to :participation, optional: true
  delegate :trip, to: :participation
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
    @restaurant.trip = self.trip
    @restaurant.save
  end

end
