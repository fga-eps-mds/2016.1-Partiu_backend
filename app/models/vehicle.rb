class Vehicle < ActiveRecord::Base
  has_many :rides, dependent: :destroy
  belongs_to :driver

  validates :car_model, presence: true, length: {maximum: 20}

end
