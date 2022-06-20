Rails.application.routes.draw do
  root(to: 'pages#home')
  get 'about', to: 'pages#about'
  get 'articles/funny', to: 'articles#funny'
  resources :articles
  get 'signup', to: 'users#new'
  post 'users '
  resources :users

end