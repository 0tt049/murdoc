Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "tree", to: "pages#tree"
  get "download", to: "pages#download"
  get "about", to: "pages#about"

  resources :nodes, only: :index
  resources :bookmarks, only: %i[index create destroy]
end
