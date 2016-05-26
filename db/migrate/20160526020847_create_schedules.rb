class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :day_of_week
      t.date :date_limit
      t.belongs_to :ride, index: true

      t.timestamps null: false
    end
  end
end
