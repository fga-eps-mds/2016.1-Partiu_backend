class PassengerSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  has_many :rides
end
