Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'blogs#index'
  devise_for :users

  resources :blogs do
    resources :posts do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[create destroy]
    end
  end
end
