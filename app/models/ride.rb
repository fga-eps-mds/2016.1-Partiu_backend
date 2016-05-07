class Ride < ActiveRecord::Base
  has_and_belongs_to_many :passagers
  belongs_to :driver
  belongs_to :vehicle
end
