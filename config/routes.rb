Rails.application.routes.draw do
  root "welcome#index"

  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout

  resources :sessions, only: [:create]
  resources :users, only: [:new, :create]
  resources :ticks, only: [:index]

  resources :strategies
end
