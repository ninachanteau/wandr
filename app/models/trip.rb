class Trip < ApplicationRecord
  has_many :participations
  has_many :users, through: :participations
  has_many :transportations, through: :participations
  has_many :accommodations, through: :participations
  has_many :restaurants, through: :participations
  has_many :activities, through: :participations
  mount_uploader :photo, PhotoUploader
  validates :destination, presence: true
  validates :name, presence: true

  scope :future, -> { where('end_date >= ?', Date.today) }
  scope :past, -> { where('end_date < ?', Date.today) }
  scope :wishlist, -> { where(start_date: nil) }

  def all_restaurants
    self.restaurants.group(:name, :date).count
  end

  def all_accommodations
    accommodations.group(:name, :start_date, :end_date).count
  end

  def all_activities
    self.activities.group(:name, :date).count
  end
end
