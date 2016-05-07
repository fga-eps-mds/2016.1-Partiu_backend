Rails.application.routes.draw do
  get "api/users" => "users#index"
  get "api/users/:id" => "users#show"
end
