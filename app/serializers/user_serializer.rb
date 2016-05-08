class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :email, :gender, :facebook_id, :link_profile,
  :photo_url, :token

  has_one :driver
  has_one :passenger
end
