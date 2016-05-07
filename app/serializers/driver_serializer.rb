class DriverSerializer < ActiveModel::Serializer
  attributes :id

  has_many :vehicles
  has_many :rides
end
