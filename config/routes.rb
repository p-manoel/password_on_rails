Rails.application.routes.draw do
  devise_for :users, class_name: "User::Record"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  resources :passwords do
    resources :shares, only: [:new, :create, :destroy]
  end

  # Defines the root path route ("/")
  root "passwords#index"
end
