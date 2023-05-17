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

  resources :chats, only: [:new, :create] # change this to only: [:new, :create] without nested routes (use params to decide which chatbot/model to use)
  resources :chatbots, except: [:edit] do
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
  resources :accounts, only: [:show, :update]
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # static pages
  get '/you_must_sign_in', to: 'static#you_must_sign_in', as: :you_must_sign_in

  # Defines the root path route ("/")
  root "chatbots#trending"
end
