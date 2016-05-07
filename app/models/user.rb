class User < ActiveRecord::Base
  has_one :driver, dependent: :destroy
  has_one :passager, dependent: :destroy
end
