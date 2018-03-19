class CreateAccommodations < ActiveRecord::Migration[5.1]
  def change
    create_table :accommodations do |t|
      t.date :start_date
      t.date :end_date
      t.string :status
      t.string :reference_number
      t.integer :number_of_nights
      t.references :participation, foreign_key: true
      t.string :address
      t.string :name
      t.string :photo
      t.string :phone_number
      t.string :url
      t.string :email
      t.float :total_price
      t.integer :number_of_rooms

      t.timestamps
    end
  end
end
