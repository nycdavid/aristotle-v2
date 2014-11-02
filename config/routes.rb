Rails.application.routes.draw do
  # Public routes
  get '/login', to: 'sessions#new', as: 'login'
  resources :sessions, only: [:create, :destroy]

  # Private routes
  resource :user, only: [:update, :edit, :show], as: 'account'
end
