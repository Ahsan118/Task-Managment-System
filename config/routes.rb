Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations' 
  }

  devise_scope :user do
    authenticated :user do
      root 'dashboards#index', as: :authenticated_user_root
    end
  end

  unauthenticated do
    root 'users/sessions#new', as: :unauthenticated_root
  end
  resources :categories
  resources :tasks do
    patch :mark_as_completed, on: :member
  end  
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
