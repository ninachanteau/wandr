class ChangeColumnsFromRestaurants < ActiveRecord::Migration[5.1]
  def change
    remove_column :restaurants, :date
    remove_column :restaurants, :start_time
    add_column :restaurants, :date, :datetime
  end
end
