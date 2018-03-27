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
    Restaurant.where(trip_id: self.id).group(:name, :date).count
  end

  def all_accommodations
    Accommodation.where(trip_id: self.id).group(:name, :start_date, :end_date).count
  end

  def all_activities
    Activity.where(trip_id: self.id).group(:name, :date).count
  end

  def all_transportations
    self.transportations.group(:departure_port, :arrival_port, :departure_date, :arrival_date, :status).count
  end
end
