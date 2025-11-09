Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Ticket Routes.
  resources :tickets do
    resources :posts
  end
  resources :ticket_types

  # User Routes.
  resources :users

  ## Session Management Routes.
  post "/auth/sign_in", to: "auth#create"
  delete "/auth/sign_out", to: "auth#destroy"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
