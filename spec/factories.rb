FactoryGirl.define do
  factory :user do
    name "forbiddenuser"
    email "forbiddenuser@forbidden.com"
    facebook_id 12314
    photo_url "myawesomephotourl.com"
  end

  factory :ride do
    title "My Ride"
    total_seats 3
    origin "Jardim do Ingá"
    destination "FGA Gama"
    departure_time Time.new
  end

  factory "vehicle" do
    color "Blackk"
    car_model "Nice cAr"
  end
end
