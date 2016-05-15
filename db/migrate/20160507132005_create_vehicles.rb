class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :color
      t.string :car_model
      t.belongs_to :driver, index: true

      t.timestamps null: false
    end
  end
end
