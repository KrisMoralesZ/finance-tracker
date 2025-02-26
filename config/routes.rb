Rails.application.routes.draw do
  resources :stocks, param: :id, only: [:index, :show]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
  get "stocks", to: "stocks#index"
  get "my_stocks", to: "stocks#my_stocks"
end
