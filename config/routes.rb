Rails.application.routes.draw do
  patch 'events/:event_id/paid', to: 'events#mark_as_paid', as: :paid
  post 'events/:id/confirmation_email', to: "events#confirmation_email", as: :events_confirmation_email
  devise_for :users
  root to: 'dashboard#show'

  resources :events
  # resource :dashboard, only: [:show], :controller => :dashboard
  get "dashboard/show", to: "dashboard#show", as: :dashboard
  resource :calendar, only: [:show], :controller => :calendar
  resource :finances, only: [:show], :controller => :finances
  post 'invoices/:id/send_email', to: "invoices#send_email", as: :invoice_send_email
  resources :invoices


  resources :clients, only: [:index, :show, :new, :create, :edit, :update]
  resources :bookings, only: [:new, :show, :create, :edit, :update, :destroy]

  resources :expenses, only: [:index, :show, :new, :create]

  get 'finances/summary', to: "finances#summary", as: :finance_summary
end
