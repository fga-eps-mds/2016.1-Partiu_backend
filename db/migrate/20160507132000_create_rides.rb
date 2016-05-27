class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :title
      t.string :origin
      t.string :destiny
      t.integer :total_seats
      t.string :route_distance
      t.string :route_time
      t.text :description
      t.boolean :schedule_ride, default: false
      t.boolean :is_finished, default: false
      t.boolean :is_subsistence_allowance, default: false
      t.belongs_to :vehicle, index: true
      t.belongs_to :driver, index: true

      t.timestamps null: false
    end
  end
end
