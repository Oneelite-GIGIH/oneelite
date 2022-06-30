Rails.application.routes.draw do
  # HOME
  root    "home_pages#index"
  get     "home",     to: "home_pages#index"
  get     "dashboard/index"

  # AUTH
  get     "sessions/new"
  get     "/signup",  to: "users#new"
  get     "/login",   to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"

  # PENGGUNA
  resources :users

end
