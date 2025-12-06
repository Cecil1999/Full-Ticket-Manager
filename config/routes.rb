Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tickets do
        resources :posts
      end
      resources :ticket_types

      # User Routes.
      resources :users do
        collection do
          get :profile
        end
      end

      # Team Routes.
      resources :teams, only: %i[ index show update destroy ]

      # Role Routes. (Keep apart from users for now, users can update via their own route.)
      resources :roles

      # ACL Routes.
      get "/acl/:ctrl(.:format)", to: "acls#show", as: "acl_controller"
      get "/acl/:ctrl/:act(.:format)", to: "acls#show", as: "acl_action"
      delete "/acl/:ctrl(.:format)", to: "acls#destroy"
      delete "/acl/:ctrl/:act(.:format)", to: "acls#destroy"

      ## Session Management Routes.
      post "/auth/sign_in", to: "auth#create"
      delete "/auth/sign_out", to: "auth#destroy"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Ticket Routes.

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
