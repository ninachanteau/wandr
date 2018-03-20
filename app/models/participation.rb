class Participation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :trip
  has_many :transportations
  has_many :accommodations
  has_many :restaurants
  has_many :activities
  has_secure_token
  after_create :send_join_trip_email

  private

  def send_join_trip_email
    ParticipationMailer.join_trip(self).deliver_now
  end

end
