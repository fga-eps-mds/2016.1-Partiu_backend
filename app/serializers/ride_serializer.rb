class RideSerializer < ActiveModel::Serializer
  attributes :id, :title, :origin, :destiny, :total_seats,
  :departure_time, :return_time, :is_finished, :is_subsistence_allowance,
  :is_only_departure, :description, :driver_id, :vehicle, :passengers, :created_at, :updated_at

  def passengers
    object.passengers.map do |passenger|
      passenger.photo_url
    end
  end
end
