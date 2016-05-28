class Schedule < ActiveRecord::Base
  belongs_to :ride
  has_many :day_of_weeks

  validates :date, :date_limit, :departure_time, presence: true
  validates :repeat, inclusion: {in: [true, false]} 
end
