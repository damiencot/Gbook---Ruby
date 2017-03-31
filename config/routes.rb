Rails.application.routes.draw do

  get 'pages/index'

  root to: 'pages#index'

  get '/profil', to: 'users#edit', as: :profil
  get '/livres/:slug', to: 'posts#types', as: :types_posts
  patch '/profil', to: 'users#update'

  # Session
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session


  resources :posts do
    collection do
      get'me'
    end
  end
  resources :passwords, only: [:new, :create, :edit, :update]
  resources :books do
    resource :subscriptions, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create] do
    # Pour les membres, je veux que tu crée une route
    member do
      # Route confirm
      get 'confirm'
    end
  end

  scope 'superadmin', module: 'admin', as: 'admin' do
    resources :types, except: [:show]
  end
end
