Rails.application.routes.draw do
  root "home_pages#index"
  
  get "home", to: "home_pages#index"
  get  "/signup",  to: "users#new"

  # get 'home_pages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
