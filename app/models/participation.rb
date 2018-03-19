class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :transportations
  has_many :accommodations
  has_many :restaurants
  has_many :activities
end
