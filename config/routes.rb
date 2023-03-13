Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/home", to: "pages#home"

  resources :nodes, only: :index
  resources :bookmarks, only: %i[index create destroy]
end
