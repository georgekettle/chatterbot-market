Rails.application.routes.draw do
  # namespace routes for chatbot to dashboard
  namespace :dashboard do
    resources :chatbots, only: [:index, :show] do
      resources :chats, only: [:index, :new, :create]
      resources :feedback, only: [:index]
      member do
        get :settings
      end
    end
  end

  resources :chatbots, except: [:edit] do
    resources :chats, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create], module: :chatbots
    resources :favorites, only: [:create], module: :chatbots do
      collection do
        delete :destroy
      end
    end
    # collection route for trending
    collection do
      get :trending
      get :search
      get :favorites, to: 'chatbots/favorites#index'
    end
  end
  resources :chats, only: [:show] do
    resources :messages, only: [:create]
  end
  resources :messages, only: [] do
    resources :feedback, only: [:create]
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
