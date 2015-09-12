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
  # React routes
  namespace :api do
    resource :user, only: [:show] do
      resources :pursuits, only: [:show] do
        resources :pomodori, only: [:create]
      end
    end
  end

  resource :admin, only: [:show] do
    resources :users, except: [:new, :create], controller: "admin/users"
  end

  resource :user, only: [:update, :edit, :show] do
    get :change_password
    resources :pursuits do
      resources :pomodori, only: [:new, :create, :show]
    end
  end
end
