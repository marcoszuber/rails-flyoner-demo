Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :feedback, only: [:new, :create]
  
  resources :aircrafts do
    resources :bookings, only: [:new, :create]
  end
  
  resources :empty_legs, only: [:index, :show, :edit, :update, :destroy]
  
  resources :bookings, except: [:new, :create] do
    resources :review_aircrafts, except: [:show, :destroy]
    resources :payments
    resources :empty_legs, only: [:new, :create]
  end
end
