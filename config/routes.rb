Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions', 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # config/routes.rb
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  root(to: 'pages#home')
  get 'about', to: 'pages#about'
  get 'game', to: 'pages#game'
  get 'articles/funny', to: 'articles#funny'
  get 'users/:id/showfriends', to: 'users#show_friends', as: 'user_connection'
  # get '/users/:id/edit', to: 'users#edits'
  # patch '/users/:id/edit', to: 'users#updates'
  resources :articles
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  resources :chatrooms
  resources :friend_requests
  resources :friendships
  resources :comments
  resources :likes
  resources :hashtags, except: [:destroy]

  post 'message', to: 'messages#create'

  mount ActionCable.server, at: '/cable'
end
