class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.references :user, foreign_key: true
      t.references :trip, foreign_key: true
      t.string :token
      t.string :pseudo
      t.string :email

      t.timestamps
    end
  end
end
