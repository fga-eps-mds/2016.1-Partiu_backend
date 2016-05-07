class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo_url, :token, :gender, :photo_url

  has_one :driver
  has_one :passenger
end
