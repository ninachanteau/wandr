class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :destination
      t.string :photo
      t.date :start_date
      t.date :end_date
      t.text :description

      t.timestamps
    end
  end
end
