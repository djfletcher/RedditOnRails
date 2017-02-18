Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show]
  resources :subs, only: [:index, :new, :create, :show, :edit, :update]
  resources :posts, only: [:new, :create, :show, :edit, :update, :destroy]
  resource :sessions, only: [:new, :create, :destroy]

end
