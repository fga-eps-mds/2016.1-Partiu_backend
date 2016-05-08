class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :car_model, :color, :driver
  has_many :rides

end
