class DayOfWeek < ActiveRecord::Base
  belongs_to :schedule

  validates :value, :departure_time, :day, presence: true

  validates :value, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6}

end
