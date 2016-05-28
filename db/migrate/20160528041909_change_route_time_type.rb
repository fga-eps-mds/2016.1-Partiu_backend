class ChangeRouteTimeType < ActiveRecord::Migration
  def change
  	change_column :rides, :route_time, :string
  end
end
