Rails.application.routes.draw do
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
end
