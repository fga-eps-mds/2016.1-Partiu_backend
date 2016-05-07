class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
