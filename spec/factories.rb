FactoryGirl.define do
  factory :user do
    name "forbiddenuser"
    email "forbiddenuser@forbidden.com"
  end

  factory :ride do
    title "My Ride"
    total_seats 3
    origin "Jardim do Ingá"
    destiny "FGA Gama"
    departure_time Time.new
  end
end
