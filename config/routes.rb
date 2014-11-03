Rails.application.routes.draw do
  # Public routes
  get '/login', to: 'sessions#new', as: 'login'
  get '/signup', to: 'users#new', as: 'sign_up'
  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:create]

  # Private routes
  resource :user, only: [:update, :edit, :show] do
    resources :pursuits
  end
end
