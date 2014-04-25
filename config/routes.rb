Musicapp::Application.routes.draw do
  resources :bands

  resources :albums

  resources :tracks

  resources :users
  root to: 'bands#index'
  post 'login', to: 'users#do_login', as: :do_login
  get 'login', to: 'users#login', as: :login
  post 'logout', to: 'users#logout'
end
