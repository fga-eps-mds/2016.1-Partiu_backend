class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :date, :date_limit, :departure_time, :return_time, :repeat, :ride, :created_at, :updated_at

  has_many :day_of_weeks
end
