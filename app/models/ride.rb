class Ride < ActiveRecord::Base
  has_and_belongs_to_many :passengers
  belongs_to :driver
  belongs_to :vehicle

  validates :title, length: {minimum: 3, maximum: 20},
                            presence: true

  validates :description, length: {maximum: 300}

  validates :total_seats, length: {in: 1..8},
                          numericality: { only_integer: true },
                          presence: true

  validates :origin, :destiny, :departure_time, presence: true


end
