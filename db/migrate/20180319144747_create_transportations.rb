class CreateTransportations < ActiveRecord::Migration[5.1]
  def change
    create_table :transportations do |t|
      t.references :participation, foreign_key: true
      t.string :type
      t.date :departure_date
      t.date :arrival_date
      t.string :departure_port
      t.string :arrival_port
      t.string :reference_number
      t.string :status
      t.float :price_per_person
      t.time :arrival_time
      t.time :departure_time

      t.timestamps
    end
  end
end
