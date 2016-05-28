class ChangeColumnsForSomeTables < ActiveRecord::Migration
  def change
  	change_column_default :rides, :is_finished, false
  	change_column_default :rides, :is_subsistence_allowance, false
  	change_column_default :rides, :schedule_ride, false
  	remove_column :day_of_weeks, :checked
  	remove_column :day_of_weeks, :day_of_week
  	add_column :schedules, :departure_time, :time
  	add_column :schedules, :return_time, :time
  	add_column :schedules, :date, :date
  	add_column :schedules, :repeat, :boolean
  	change_column_default :schedules, :repeat, false
  end
end
