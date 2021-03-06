Rails.application.routes.draw do

  root                     'static_pages#home'
  get  	 '/help',      to: 'static_pages#help'
  get  	 '/contact',   to: 'static_pages#contact'
  get  	 '/about',     to: 'static_pages#about'
  get  	 '/signup',    to: 'users#new'
  post 	 '/signup',    to: 'users#create'
  get  	 '/login',     to: 'sessions#new'
  post 	 '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'
  get    '/study',     to: 'words#study'
  get    '/load_more', to: 'posts#load_more'

  resources :users, except: [:new, :create] do
    member do
      get :words
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :words
  resources :relationships,       only: [:create, :destroy]

  resources :posts, except: [:new] do
    resources :comments, except: [:index, :new, :show]
  end

end
