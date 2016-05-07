class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :email, :gender, :facebook_id, :link_profile , :photo_url, :token, :photo_url

  has_one :driver
  has_one :passenger
end
