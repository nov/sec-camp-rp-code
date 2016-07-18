Rails.application.routes.draw do
  resource :session, only: [:new, :destroy]
  get 'callback', to: 'sessions#create'
  root to: 'top#index'
end
