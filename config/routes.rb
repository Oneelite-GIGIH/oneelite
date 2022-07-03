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
  get       "/current/user", to: "users#get_current_user"

  # ORDER
  get   "/order/onepick",                             to: "order#show_list_onepick_order",    as: :show_list_onepick_order
  get   "/order/onepick/new",                         to: "order#show_create_onepick_order",  as: :show_create_onepick_order
  post  "/order/onepick/new",                         to: "order#create_onepick_order",       as: :create_onepick_order
  get   "/order/history",                             to: "order#show_transaction_history",   as: :show_transaction_history
  get   "/transactions",                              to: "order#show_all_transactions",      as: :show_all_transactions
  post  "/transactions/:transaction_id/:new_status",  to: "order#change_transaction_status",  as: :change_transaction_status
  post  "/transactions/:transaction_id/confirm",      to: "order#confirm_transaction",        as: :confirm_transaction
end
