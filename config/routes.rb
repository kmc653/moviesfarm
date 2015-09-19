Rails.application.routes.draw do
  
  get '/home' => 'movies#index'
  get '/register' => 'users#new'
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'

  resources :movies do
    
    collection do
      get 'search'
    end
    
    member do
      get 'like' => 'movies#upvote'
      get 'dislike' => 'movies#downvote'
    end

    resources :reviews, except: [:show, :index]
  end
  resources :users, only: [:index, :create]
  resources :sessions, only: [:create]
end