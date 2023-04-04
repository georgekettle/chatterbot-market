Rails.application.routes.draw do
  # namespace routes for chatbot to dashboard
  namespace :dashboard do
    resources :chatbots, only: [:index, :show] do
      resources :conversations, only: [:index]
      resources :feedback, only: [:index]
      member do
        get :settings
      end
    end
  end

  resources :chatbots do
    resources :conversations, only: [:new, :create]
  end
  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end
  resources :messages, only: [] do
    resources :feedback, only: [:create]
  end
  resources :feedback, only: [:update]
  get '/account_settings', to: 'accounts#account_settings', as: :account_settings
  resources :accounts, only: [:update]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#home"
end
