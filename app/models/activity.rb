class Activity < ApplicationRecord
  belongs_to :participation
  mount_uploader :photo, PhotoUploader
end
