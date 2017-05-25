Rails.application.routes.draw do

  root 'static_pages#home'
  get  	 '/help',    to: 'static_pages#help'
  get  	 '/contact', to: 'static_pages#contact'
  get  	 '/about',   to: 'static_pages#about'
  get  	 '/signup',  to: 'users#new'
  post 	 '/signup',  to: 'users#create'
  get  	 '/login',   to: 'sessions#new'
  post 	 '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, except: [:new, :create]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

end
