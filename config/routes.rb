Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root 'trips#index', as: :authenticated_root
  end

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips, only: [:index, :show, :new, :create, :edit, :update] do
    resources :transportations, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :accommodations, only: [:create, :edit, :update]
    resources :restaurants, only: [:create, :edit, :update]
    resources :activities, only: [:create, :edit, :update]
    resources :participations, only: [:create, :edit, :update, :destroy]
  end

  resources :restaurants, only: [:create, :edit, :update]
  resources :activities, only: [:create, :edit, :update]
  resources :accommodations, only: [:create, :edit, :update]
end
