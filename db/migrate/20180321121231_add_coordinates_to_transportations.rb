class AddCoordinatesToTransportations < ActiveRecord::Migration[5.1]
  def change
    add_column :transportations, :departure_port_latitude, :float
    add_column :transportations, :departure_port_longitude, :float
    add_column :transportations, :arrival_port_latitude, :float
    add_column :transportations, :arrival_port_longitude, :float
  end
end
