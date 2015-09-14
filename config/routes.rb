Rails.application.routes.draw do
  
  get '/home' => 'movies#index'
  get '/register' => 'users#new'

  resources :movies
  resources :users, only: [:index, :create]
end
