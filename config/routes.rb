Rails.application.routes.draw do

  scope "/api" do
    get 'get_user_id', to: 'users#get_user_id'
  	get 'forbidden', to: 'application#forbidden'
    resources :users do
      resources :rides
      resources :vehicles
    end

    get 'rides', to: 'rides#index'
    get 'rides/:id', to: 'rides#show'
  end

  get 'static_pages/privacy'
end
