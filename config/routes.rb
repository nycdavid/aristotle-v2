Rails.application.routes.draw do
  get 'errors/not_found'

  root to: 'pages#home'

  # Public routes
  get '/login', to: 'sessions#new', as: 'login'
  get '/signup', to: 'users#new', as: 'sign_up'
  match '/404', to: 'errors#not_found', via: :all
  resource :session, only: [:create, :destroy]
  resources :users, only: [:create]

  # Private routes
  resource :user, only: [:update, :edit, :show] do
    resources :pursuits do
      resources :pomodori, only: [:new, :create]
    end
  end
end
