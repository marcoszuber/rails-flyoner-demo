Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "my_aircrafts", to: "aircrafts#my_aircrafts"
  resources :feedback, only: [:new, :create]
  resources :aircrafts do
    resources :bookings, only: [:new, :create]
    resources :review_aircrafts, only: [:index]
  end

  resources :empty_legs, only: [:index, :show, :edit, :update, :destroy]

  resources :bookings, except: [:new, :create] do
    resources :review_aircrafts, except: [:show, :destroy, :index]
    resources :payments
    resources :empty_legs, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
