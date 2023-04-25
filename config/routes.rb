Rails.application.routes.draw do
  # namespace routes for chatbot to dashboard
  namespace :dashboard do
    resources :chatbots, only: [:index, :show] do
      resources :corrections, only: [:index]
      resources :csv_fine_tunes, only: [:index, :new, :create]
      resources :conversations, only: [:index, :new, :create]
      resources :feedback, only: [:index]
      member do
        get :settings
      end
    end
  end
  resources :chatbots, except: [:edit] do
    resources :conversations, only: [:new, :create]
  end
  resources :corrections, only: [:edit, :update, :destroy]
  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end
  resources :messages, only: [] do
    resources :feedback, only: [:create]
    resources :corrections, only: [:new, :create], controller: 'messages/corrections'
  end
  resources :feedback, only: [:update] do
    member do
      patch :toggle_marked_read_at
    end
  end
  get '/account_settings', to: 'accounts#account_settings', as: :account_settings
  resources :accounts, only: [:update]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static#home"
end
