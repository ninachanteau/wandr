class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, PhotoUploader
  has_many :participations
  has_many :trips, through: :participations
  has_many :transportations, through: :participations
  has_many :accommodations, through: :participations
  has_many :restaurants, through: :participations
  has_many :activities, through: :participations

  def future_trips
    self.trips.select { |trip| trip unless trip.end_date.past? }
  end

  def past_trips
    self.trips.select { |trip| trip if trip.end_date.past? }
  end
end
