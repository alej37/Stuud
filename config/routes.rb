Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resource :dashboard, only: [:show]
  resource :calendar, only: [:show]

  resources :clients, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:new, :create]
  end
  resources :expenses, only: [:index, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end