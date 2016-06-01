class AddColumDescriptionToVehicle < ActiveRecord::Migration
  def change
   add_column :vehicles, :description, :text 
  end
end
