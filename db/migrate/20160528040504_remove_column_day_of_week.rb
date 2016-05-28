class RemoveColumnDayOfWeek < ActiveRecord::Migration
  def change
  	remove_column :schedules, :day_of_week
  end
end
