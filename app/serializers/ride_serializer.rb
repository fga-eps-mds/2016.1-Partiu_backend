class RideSerializer < ActiveModel::Serializer
  attributes :id, :title, :origin, :destiny, :total_seats,
  :departure_time, :return_time, :is_finished, :is_subsistence_allowance,
  :is_only_departure, :description, :driver_name, :driver_photo, :vehicle_model,
  :vehicle_color, :passengers_name, :passengers_photo, :created_at, :updated_at

  def driver_name
    object.driver.name
  end

  def driver_photo
    object.driver.photo_url
  end

  def vehicle_model
    object.vehicle.car_model
  end

  def vehicle_color
    object.vehicle.color
  end

  def passengers_name
    object.passengers.map do |passenger|
      passenger.name
    end
  end

  def passengers_photo
    object.passengers.map do |passenger|
      passenger.photo_url
    end
  end

end
