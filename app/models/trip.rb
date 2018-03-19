class Trip < ApplicationRecord
  has_many :participations
  has_many :transportations, through: :participations
  has_many :accommodations, through: :participations
  has_many :restaurants, through: :participations
  has_many :activities, through: :participations
  mount_uploader :photo, PhotoUploader
end
