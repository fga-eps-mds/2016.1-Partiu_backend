class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :car_model, :color, :description, :driver
  has_many :rides
end
