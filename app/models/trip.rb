class Trip < ApplicationRecord
  has_many :participations
  has_many :transportations, through: :participations
  has_many :accommodations, through: :participations
  has_many :restaurants, through: :participations
  has_many :activities, through: :participations
  mount_uploader :photo, PhotoUploader

  def future_trips
    self.select { |trip| trip unless trip.end_date.past? }
  end

  def past_trips
    self.select { |trip| trip if trip.end_date.past? }
  end
end
