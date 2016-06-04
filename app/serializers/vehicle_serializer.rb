class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :car_model, :color, :description, :driver, :rides

  def rides
    object.rides.map do |ride|
      ride.id
    end
  end
end
