Rails.application.routes.draw do
  root 'blogs#index'
  devise_for :users

  resources :blogs do
    resources :comments, only: %i[new create destroy]
    resources :likes, only: %i[create destroy]
    resources :posts
  end
  
  resources :posts, only: [] do
    resources :comments, only: %i[new create destroy]
    resources :likes, only: %i[create destroy]
  end
end
