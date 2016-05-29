FactoryGirl.define do
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
    date "21/08/2016"
    departure_time "11:45"
    return_time "20:00"
    description "Carona para o jardim do Ingá"
    is_finished false
    is_subsistence_allowance true
  end

  factory :vehicle do
    color "Black"
    car_model "Celta"
  end
end
