Rails.application.routes.draw do
  # HOME
  root to: 'main#index', as: :home

  # AUTH

  # PENGGUNA

  # KURIR

  # ORDER
  get '/order/onepick', to: 'order#show_list_onepick_order', as: :show_list_onepick_order
  get '/order/onepick/new', to: 'order#show_create_onepick_order', as: :show_create_onepick_order
  post '/order/onepick/new', to: 'order#create_onepick_order', as: :create_onepick_order
end
