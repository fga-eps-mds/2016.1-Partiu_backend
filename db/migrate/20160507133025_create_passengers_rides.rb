class CreatePassengersRides < ActiveRecord::Migration
  def change
    create_table :passengers_rides, id: false do |t|
      t.references :ride, index: true, foreign_key: true
      t.references :passenger, index: true, foreign_key: true
    end
  end
end
