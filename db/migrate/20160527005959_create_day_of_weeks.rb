class CreateDayOfWeeks < ActiveRecord::Migration
  def change
    create_table :day_of_weeks do |t|
      t.string :day
      t.boolean :checked, default: false
      t.integer :value
      t.time :departure_time
      t.time :return_time
      t.belongs_to :schedule, index: true

      t.timestamps null: false
    end
  end
end
