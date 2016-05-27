Rails.application.routes.draw do
  scope "/api" do
    resources :users do
      resources :rides do
        resources :schedules do
          resources :day_of_weeks
        end
      end
      resources :vehicles
    end

    get 'rides', to: 'rides#index'
    get 'rides/:id', to: 'rides#show'
  end
end
