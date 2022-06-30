Rails.application.routes.draw do
  get 'dashboard/index'
  get 'sessions/new'
  root    "home_pages#index"
  get     "home",     to: "home_pages#index"
  get     "/signup",  to: "users#new"
  get     "/login",   to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"

  resources :users

  # get 'home_pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
