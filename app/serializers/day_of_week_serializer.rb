class DayOfWeekSerializer < ActiveModel::Serializer
  attributes :id, :day, :value, :departure_time, :return_time, :schedule
end
