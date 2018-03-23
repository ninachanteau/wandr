class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url(*args)
    if self.model.class == User
      ActionController::Base.helpers.asset_path(["default-user.jpg"].compact.join('_'))
    elsif self.model.class == Trip
      ActionController::Base.helpers.asset_path(["default-trip.jpg"].compact.join('_'))
    elsif self.model.class == Accommodation
      ActionController::Base.helpers.asset_path(["default-accommodation.jpg"].compact.join('_'))
    elsif self.model.class == Restaurant
      ActionController::Base.helpers.asset_path(["default-restaurant.jpg"].compact.join('_'))
    elsif self.model.class == Activity
      ActionController::Base.helpers.asset_path(["default-activity.jpg"].compact.join('_'))
    end
  end

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :thumnail do
    resize_to_fit 256, 256
  end

  version :bright_face do
    cloudinary_transformation effect: "brightness:30", radius: 20,
      width: 150, height: 150, crop: :thumb, gravity: :face
  end
end
