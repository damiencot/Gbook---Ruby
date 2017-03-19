Rails.application.routes.draw do

  root to: 'users#new'

  get '/profil', to: 'users#edit', as: :profil
  patch '/profil', to: 'users#update'

  # Session
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  resources :passwords, only: [:new, :create, :edit, :update]
  resources :books
  resources :users, only: [:new, :create] do
    # Pour les membres, je veux que tu crée une route
    member do
      # Route confirm
      get 'confirm'
    end
  end

end
