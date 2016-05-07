class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :title
      t.string :origin
      t.string :destiny
      t.integer :total_seats
      t.datetime :departure_time
      t.datetime :return_time
      t.boolean :is_finished
      t.boolean :is_subsistence_allowance
      t.boolean :is_only_departure
      t.text :description
      t.belongs_to :vehicle, index: true
      t.belongs_to :driver, index: true

      t.timestamps null: false
    end
  end
end
