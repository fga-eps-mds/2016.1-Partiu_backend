class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :car_model, :color, :description, :driver_name, :driver_photo

  def driver_name
    object.driver.name
  end

  def driver_photo
    object.driver.photo_url
  end

  has_many :rides
end
