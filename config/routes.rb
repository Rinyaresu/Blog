Rails.application.routes.draw do
  resources :articles, except: [:index]
  devise_for :users
  resources :about, only: [:index]
  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main#index'
end
