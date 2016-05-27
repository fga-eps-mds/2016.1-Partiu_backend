class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :date
      t.date :date_limit
      t.time :departure_time
      t.time :return_time
      t.boolean :repeat, default: false
      t.belongs_to :ride, index: true

      t.timestamps null: false
    end
  end
end
