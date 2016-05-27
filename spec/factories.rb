FactoryGirl.define do
  factory :day_of_week do
    
  end
  
  factory :schedule do
  end

  factory :user do
    name "forbiddenuser"
    email "forbiddenuser@forbidden.com"
    facebook_id "12315"
    photo_url "myawesomephotourl.com"
  end

  factory :ride do
    title "My Ride"
    origin "Jardim do Ingá"
    destiny "FGA Gama"
    total_seats 3
  end

  factory "vehicle" do
    color "Black"
    car_model "Celta"
  end
end
