Rails.application.routes.draw do
  get 'home/index'

   # Login and register
   get 'register', :to => 'users#new'
   get 'login', :to => 'session#login'
   post 'login', :to =>  'session#create'
   post 'logout', :to =>  'session#destroy'
   get 'logout', :to => 'session#destroy'

  root  'session#home'

  # resources
  resources :recipes_lists
  resources :shopping_lists
  resources :recipe_ingredients
  resources :steps
  resources :recipes
  resources :ingredients
  resources :followed_lists
  resources :lists
  resources :followings
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      post 'login', :to =>  'login#create'
      resources :recipes_lists
      resources :shopping_lists
      resources :recipe_ingredients
      resources :steps
      resources :recipes
      resources :ingredients
      resources :followed_lists
      resources :lists
      resources :followings
      resources :users
    end
  end
end
