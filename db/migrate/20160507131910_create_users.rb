class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :token
      t.string :gender
      t.string :photo_url
      t.string :facebook_id
      t.string :link_profile

      t.timestamps null: false
    end
  end
end
