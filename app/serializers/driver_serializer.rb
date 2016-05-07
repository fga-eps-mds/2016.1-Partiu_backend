class DriverSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  has_many :vehicles
  has_many :rides
end
