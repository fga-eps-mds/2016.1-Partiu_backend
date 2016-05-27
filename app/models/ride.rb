class Ride < ActiveRecord::Base
  has_and_belongs_to_many :passengers
  has_many :schedules
  belongs_to :driver
  belongs_to :vehicle

  validates :title, length: {minimum: 3, maximum: 20},
                            presence: true

  validates :description, length: {maximum: 300}

  validates :total_seats, presence: true,
    numericality: {only_integer:true, greater_than_or_equal_to: 1, less_than_or_equal_to: 8}

  validates :origin, :destiny, :route_distance, :route_time, presence: true

  validates :is_finished, :is_subsistence_allowance, :schedule_ride, inclusion: {in: [true, false]}

  validates :driver_id, presence: true

end
