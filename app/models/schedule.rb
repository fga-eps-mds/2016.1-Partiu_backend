class Schedule < ActiveRecord::Base
  belongs_to :ride
  has_many :day_of_weeks
end
