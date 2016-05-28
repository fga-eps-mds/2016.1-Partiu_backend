FactoryGirl.define do
  factory :day_of_week do
   day "quarta-feira"
   value 3
   departure_time "11:29"
   return_time "20:00"
  end
  
  factory :schedule do
    date "21/09/2016"
    date_limit "22/09/2016"
    departure_time "07:30"
    return_time "18:00"
    repeat false
  end

  factory :user do
    name "forbiddenuser"
    phone "(51) 1234-1029"
    email "forbiddenuser@forbidden.com"
    token "FGOR9403KDIS"
    gender "Masculino"
    photo_url "myawesomephotourl.com"
    facebook_id "12315"
    link_profile "forbiddenuser@facebook.com"
  end

  factory :ride do
    title "My Ride"
    origin "Jardim do Ingá"
    destination "FGA Gama"
    total_seats 3
    route_distance "34km"
    route_time "30 minutos"
    description "Carona para o jardim do Ingá"
    schedule_ride true
    is_finished false
    is_subsistence_allowance true
  end

  factory "vehicle" do
    color "Black"
    car_model "Celta"
  end
end
