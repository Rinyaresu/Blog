Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
  end

  resources :articles, except: [:index]

  devise_for :users, skip: [:registrations]
  as :user do
    get "users/edit" => "devise/registrations#edit",
        :as => "edit_user_registration"
    put "users" => "devise/registrations#update", :as => "user_registration"
  end

  resources :about, only: [:index]

  get "main/index"

  root "main#index"
end
