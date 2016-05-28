class RemoveSomeColumns < ActiveRecord::Migration
  def change
  	remove_column :rides, :return_time
  	remove_column :rides, :date
  end
end
