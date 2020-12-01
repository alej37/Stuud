Rails.application.routes.draw do
  resources :events
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'dashboard#show'

  post '/stripe/webhook', to: 'stripe_webhooks#event'

  resource :dashboard, only: [:show], :controller => :dashboard
  resource :calendar, only: [:show], :controller => :calendar
  resource :finances, only: [:show], :controller => :finances

  resources :clients, only: [:index, :show, :new, :create, :edit, :update]
  resources :bookings, only: [:new, :show, :create, :edit, :update, :destroy]

  resources :expenses, only: [:index, :show, :new, :create]
end
