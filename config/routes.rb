Rails.application.routes.draw do
  root to: 'admin/users#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :tasks
  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
