Wun::Application.routes.draw do
  devise_for :users

  resources :lists, except: [:new] do
  	collection { post :sort }
  end

  resources :items, only: [:index, :edit, :create, :update, :destroy] do
  	collection do
  		post :sort
  		get :autocomplete_item_name
  	end
  end

  get "pages/home"
  root :to => 'pages#home'
end