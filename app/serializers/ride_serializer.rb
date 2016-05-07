class RideSerializer < ActiveModel::Serializer
  attributes :id, :title, :origin, :destiny, :total_seats,
  :departure_time, :return_time, :is_finished, :is_subsistence_allowance,
  :is_only_departure, :description, :driver_id, :vehicle, :passagers, :created_at, :updated_at

  def passagers
    object.passagers.map do |passager|
      passager.name && passager.photo_url
    end
  end
end
