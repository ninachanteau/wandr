class AddCoordinatesToAccommodations < ActiveRecord::Migration[5.1]
  def change
    add_column :accommodations, :latitude, :float
    add_column :accommodations, :longitude, :float
  end
end
