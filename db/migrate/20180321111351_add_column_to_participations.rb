class AddColumnToParticipations < ActiveRecord::Migration[5.1]
  def change
    add_column :participations, :avatar, :string
  end
end
