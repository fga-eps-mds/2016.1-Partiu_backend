class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :title
      t.string :origin
      t.string :destiny
      t.integer :total_seats
      t.string :departure_time
      t.string :return_time
      t.string :distance
      t.time :time
      t.date :date
      t.boolean :is_finished
      t.boolean :is_subsistence_allowance
      t.boolean :schedule_ride
      t.text :description
      t.belongs_to :vehicle, index: true
      t.belongs_to :driver, index: true

      t.timestamps null: false
    end
  end
end
