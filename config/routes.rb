Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root 'trips#index', as: :authenticated_root
  end

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips, only: [:index, :show, :new, :create, :edit, :update] do
    resources :transportations, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :accommodations, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :restaurants, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :activities, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :participations, only: [:create, :edit, :update, :destroy]
    namespace :trips do
      resources :navbar_restaurants, only: [:new, :create, :edit, :update]
      resources :navbar_accommodations, only: [:new, :create, :edit, :update]
      resources :navbar_activities, only: [:new, :create, :edit, :update]
    end
    get :recap, on: :member
    get :calendar, on: :member
  end

  resources :restaurants, only: [:create, :edit, :update]
  resources :activities, only: [:create, :edit, :update]
  resources :accommodations, only: [:create, :edit, :update]

  namespace :trips do
    resources :unauthenticated, only: [:show, :edit, :update] do
      resources :transportations, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :accommodations, only: [:index, :new, :create, :edit, :update]
      resources :restaurants, only: [:index, :new, :create, :edit, :update]
      resources :activities, only: [:index, :new, :create, :edit, :update]
      resources :participations, only: [:create, :edit, :update, :destroy]
    end
    resources :navbar_restaurants, only: [:new, :create, :edit, :update]
    resources :navbar_accommodations, only: [:new, :create, :edit, :update]
    resources :navbar_activities, only: [:new, :create, :edit, :update]
  end

end
