Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  namespace :api do
    resources :wishlists, only: [:create, :destroy]
  end
  resources :properties, only: [:show] do
    resources :bookings, only: [:new]
  end

  resources :booking_payments, only: [:create]

  get "booking_payments/success", to: "booking_payments#success"
  resources :wishlists, only: [:index]

  resource :profile, only: [:edit, :update]

  resource :email, only: [:edit, :update]

  resource :password, only: [:edit, :update]

  resources :reservations, only: [:index] do
    resources :reviews, only: [:new, :create]
  end

  namespace :owner do
    resources :dashboard, only: :index
    resources :properties do
      member do
        patch 'update_amenities'
      end
    end
    resources :reservations, only: :index
  end
end
