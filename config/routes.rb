Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :feedback, only: [:new, :create]
  resources :aircrafts do
    resources :bookings, only: [:new, :create] do
      resources :payments
      resources :review_aircrafts, only: [:new, :create]
      resources :empty_legs, only: [:new, :create]
    end
  end
  resources :empty_legs, only: [:index, :show, :edit, :update, :destroy]
  resources :bookings, except: [:new, :create]
  resources :review_aircrafts, only: [:index, :show, :edit, :update]
end
