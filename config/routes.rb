Rails.application.routes.draw do

  get 'static_pages/home'

  scope "/api" do
    post 'insert_passenger', to: 'rides#insert_passenger'
    get 'get_user_id', to: 'users#get_user_id'
  	get 'forbidden', to: 'application#forbidden'
    resources :users do
      resources :rides
      resources :vehicles
    end

    get 'rides', to: 'rides#index'
    get 'rides/:id', to: 'rides#show'
  end

  get "privacy", to: "static_pages#privacy"
  root "static_pages#home"
end
