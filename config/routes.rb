Rails.application.routes.draw do
  get 'home/index'

   # Login and register
   get 'register', :to => 'users#new'
   get 'login', :to => 'session#login'
   post 'login', :to =>  'session#create'
   post 'logout', :to =>  'session#destroy'
   get 'logout', :to => 'session#destroy'
   get 'profile', :to => 'session#profile'
   get 'profile/:id' => 'session#profile'
   get 'search', :to => 'session#search'
   post 'search_users', :to => 'session#search_users'
   post 'search_lists', :to => 'session#search_lists'
   post 'search_recipes', :to => 'session#search_recipes'
   get 'follow', :to => 'session#follow'
   get 'follow/:id_current/:id_unfollow', :to => 'session#follow'
   get 'unfollow', :to => 'session#unfollow'
   get 'unfollow/:id_current/:id_unfollow', :to => 'session#unfollow'
   get 'follow_list', :to => 'session#follow_list'
   get 'follow_list/:id_current/:id_unfollow', :to => 'session#follow_list'
   get 'unfollow_list', :to => 'session#unfollow_list'
   get 'unfollow_list/:id_current/:id_unfollow', :to => 'session#unfollow_list'
   get 'save_recipe', :to => 'session#save_recipe'
   get 'save_recipe/:id_user/:id_recipe', :to => 'session#save_recipe'
   get 'unsave_recipe', :to => 'session#unsave_recipe'
   get 'unsave_recipe/:id_user/:id_recipe', :to => 'session#unsave_recipe'
   get 'rate', :to => 'ratings#new'
   get 'rate/:recipe_id', :to => 'ratings#new'
   get 'rate_recipe', :to => 'session#rate'
   get 'rate/:recipe_id', :to => 'session#rate'

  root  'session#home'

  # resources
  resources :posts
  resources :ratings
  resources :comments
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
      post 'rating', :to =>  'recipes#rating'
      resources :posts
      resources :ratings
      resources :comments
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
