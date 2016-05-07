class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :car_model, :color, :description, :driver_id

  has_many :rides
end
