class RideSerializer < ActiveModel::Serializer
  attributes :id, :title, :origin, :destination, :route_distance, :route_time, :date, 
  :total_seats, :departure_time, :return_time, :is_finished, :is_subsistence_allowance,
  :description, :driver, :vehicle, :passengers_name, :passengers_photo, :created_at, :updated_at


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
