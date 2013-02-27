Wun::Application.routes.draw do
  devise_for :users

  resources :lists, except: [:new]
  resources :items, only: [:edit, :create, :update, :destroy]

  get "pages/home"
  root :to => 'pages#home'
end