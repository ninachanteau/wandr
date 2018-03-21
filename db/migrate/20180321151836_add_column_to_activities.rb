class AddColumnToActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :activities, :trip, index: true
  end
end
