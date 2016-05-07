class User < ActiveRecord::Base
  has_one :driver, dependent: :destroy
  has_one :passenger, dependent: :destroy
end
