class PassengerSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo_url

  has_many :rides
end
