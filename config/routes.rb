Rails.application.routes.draw do
  # HOME
  root to: 'main#index', :as => :home

  # AUTH

  # PENGGUNA

  # KURIR

  # ORDER
  get '/create/order/onepick', to: 'order#show_create_onepick_order', :as => :show_create_onepick_order
  post '/create/order/onepick', to: 'order#create_onepick_order', :as => :create_onepick_order
end
