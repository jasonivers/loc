Rails.application.routes.draw do
  get 'accounts/:account_id/:type', to: 'transactions#new'
  post 'transactions', to: 'transactions#create'
  resources :accounts, except: [:destroy]
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'core#index'
end
