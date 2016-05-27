class ChangeRideTable < ActiveRecord::Migration
  def change
    rename_column :rides, :destiny, :destination
  end
end
