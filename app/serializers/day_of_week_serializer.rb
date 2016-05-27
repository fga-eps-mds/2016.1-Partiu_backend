class DayOfWeekSerializer < ActiveModel::Serializer
  attributes :id, :day, :checked, :value, :departure_time, :return_time, :schedule_id
end
