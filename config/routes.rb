Wun::Application.routes.draw do
  devise_for :users, path_names: { sign_up: 'register', sign_in: 'login', sign_out: 'logout' }

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