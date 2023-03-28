Rails.application.routes.draw do
  resources :chatbots do
    resources :conversations, only: [:index, :new, :create]
  end
  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#home"
end
