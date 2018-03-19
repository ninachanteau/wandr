class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.date :date
      t.time :start_time
      t.string :status
      t.references :participation, foreign_key: true
      t.string :address
      t.string :name
      t.string :photo
      t.string :phone_number
      t.text :description
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end
