class AddColumnToAccommodations < ActiveRecord::Migration[5.1]
  def change
    add_reference :accommodations, :trip, index: true
  end
end
