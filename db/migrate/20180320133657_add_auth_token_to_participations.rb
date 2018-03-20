class AddAuthTokenToParticipations < ActiveRecord::Migration[5.1]
  def change
    add_column :participations, :auth_token, :string
    add_index :participations, :auth_token, unique: true
  end
end
