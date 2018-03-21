class ChangeColumnsfromTransportations < ActiveRecord::Migration[5.1]
  def change
    remove_column :transportations, :departure_date
    remove_column :transportations, :arrival_date
    remove_column :transportations, :departure_time
    remove_column :transportations, :arrival_time
    add_column :transportations, :departure_date, :datetime
    add_column :transportations, :arrival_date, :datetime
  end
end
