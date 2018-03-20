class Restaurant < ApplicationRecord
  belongs_to :participation, optional: true
  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
