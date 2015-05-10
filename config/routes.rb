Rails.application.routes.draw do
  get 'errors/not_found'

  root to: 'pages#home'

  # Public routes
  get '/login', to: 'sessions#new', as: 'login'
  get '/signup', to: 'users#new', as: 'sign_up'
  match '/404', to: 'errors#not_found', via: :all
  resource :session, only: [:create, :destroy]
  resources :users, only: [:create]
  resources :password_resets, only: [:new, :create, :edit, :index, :update]

  # Private routes
  resource :user, only: [:update, :edit, :show] do
    get :change_password
    resources :pursuits do
      resources :pomodori, only: [:new, :create, :show]
    end
  end
end
