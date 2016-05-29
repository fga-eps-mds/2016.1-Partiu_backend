class ChangeRideTable < ActiveRecord::Migration
  def change
    change_column :rides, :time, :string
    rename_column :rides, :time, :route_time
    rename_column :rides, :distance, :route_distance
    change_column :rides, :departure_time, :time
    change_column :rides, :return_time, :time
    rename_column :rides, :destiny, :destination
    remove_column :rides, :schedule_ride
    change_column_default :rides, :is_finished, false
    change_column_default :rides, :is_subsistence_allowance, false
  end
end
