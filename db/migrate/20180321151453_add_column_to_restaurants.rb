class AddColumnToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_reference :restaurants, :trip, index: true
  end
end
