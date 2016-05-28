class DayOfWeek < ActiveRecord::Base
  belongs_to :schedule

  validates :value, :departure_time, :day, presence: true
end
