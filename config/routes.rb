Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :blogs do
    resources :posts
  end
end
