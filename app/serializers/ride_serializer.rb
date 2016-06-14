class RideSerializer < ActiveModel::Serializer
  attributes :id, :title, :origin, :destination, :route_distance, :route_time, :date,
  :total_seats, :departure_time, :return_time, :is_finished, :is_subsistence_allowance,
  :description, :driver, :vehicle_id, :passengers, :created_at, :updated_at

  def passengers
    object.passengers.map do |passenger|
      passenger.id
    end
  end

end
