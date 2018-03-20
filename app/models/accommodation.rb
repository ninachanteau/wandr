class Accommodation < ApplicationRecord
  belongs_to :participation, optional: true
  mount_uploader :photo, PhotoUploader
end
