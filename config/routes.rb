Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users

  resources :posts, only: [:create, :destroy]
  resource :users, only: [:show]
  resources :groups
  resource :comments, only: [:create]
end
