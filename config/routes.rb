Rails.application.routes.draw do
  get "api/users" => "users#index"
  get "api/users/:id" => "users#show"
  get "api/users/:id/rides" => "rides#index"
  get "api/users/:id/rides/:id" => "rides#show"
  get "api/users/:id/vehicles" => "vehicles#index"
  get "api/users/:id/vehicles/:id" => "vehicles#show" 
end
