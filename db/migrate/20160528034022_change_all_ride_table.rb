class ChangeAllRideTable < ActiveRecord::Migration
  def change
  	rename_column :rides, :distance, :route_distance
  	rename_column :rides, :time, :route_time
  	remove_column :rides, :departure_time, :return_time, :date
  end
end
