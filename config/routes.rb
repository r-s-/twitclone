SampleApp::Application.routes.draw do

  # RESTful user routes
  resources :users

  # static pages routes
  root 'static_pages#home'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  # User Athentication
  # edit omitted
  resources :sessions, only: [:new, :create, :destroy] 
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :microposts, only: [:create, :destroy]

end
