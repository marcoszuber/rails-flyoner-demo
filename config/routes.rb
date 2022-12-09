Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "my_aircrafts", to: "aircrafts#my_aircrafts"
  post "process_payment", to: "payments#process_payment"
  get "payments_status", to: "payments#payments_status"
  resources :feedback, only: [:new, :create]
  resources :aircrafts do
    resources :bookings, only: [:new, :create]
    resources :review_aircrafts, only: [:index]
  end

  resources :empty_legs, only: [:index, :show, :edit, :update, :destroy]

  resources :bookings, except: [:new, :create] do
    resources :review_aircrafts, except: [:show, :destroy, :index]
    resources :payments, only: [:new, :create]
    resources :empty_legs, only: [:new, :create]
  end

  resources :payments, except: [:new, :create]

end
