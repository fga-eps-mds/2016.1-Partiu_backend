Rails.application.routes.draw do
  scope "/api" do
    resources :users do
      resources :rides
      resources :vehicles
    end
  end
end
