Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users

  resources :posts, only: %i(create destroy)
  resource :users, only: %i(show)
  resources :groups do
    resources :posts, only: %i(create destroy)
    resource :comments, only: %i(create)
  end
  resource :comments, only: %i(create)
  resources :user_groups, only: %i(create destroy)
end
