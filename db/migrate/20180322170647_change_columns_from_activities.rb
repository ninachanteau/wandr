class ChangeColumnsFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :date
    remove_column :activities, :start_time
    add_column :activities, :date, :datetime
  end
end
