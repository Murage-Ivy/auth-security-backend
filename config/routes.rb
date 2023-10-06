Rails.application.routes.draw do
  resources :feedbacks
  resources :requests
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :refresh_tokens, only: [] do
    post "create", on: :collection
    delete "revoke", on: :collection
  end

  post "/login", to: "auth#create"
  get "/facilitator", to: "facilitators#index"
end
