class RemoveColumnfromParticipations < ActiveRecord::Migration[5.1]
  def change
    remove_column :participations, :auth_token
  end
end
