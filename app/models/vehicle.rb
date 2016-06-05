class Vehicle < ActiveRecord::Base
  has_many :rides
  belongs_to :driver

  validates :car_model, presence: true, length: {minimum: 2, maximum: 20}
  validates :color, presence: true, length: {minimum: 2, maximum: 20}
  validates :description, length: {maximum: 300}
  validates :driver_id, presence: true
end
