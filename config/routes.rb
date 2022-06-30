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

  # ORDER
  get '/order/onepick', to: 'order#show_list_onepick_order', as: :show_list_onepick_order
  get '/order/onepick/new', to: 'order#show_create_onepick_order', as: :show_create_onepick_order
  post '/order/onepick/new', to: 'order#create_onepick_order', as: :create_onepick_order
end
