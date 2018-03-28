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
  validates_uniqueness_of :email

  def new_count(trip, method_name)
    @new_items = method_name.all.select do |item|
      if item.trip
      item.created_at > self.last_sign_in_at && item.trip.id == trip.id
      end
    end
    return @new_items.count
  end
end



