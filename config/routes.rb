Rails3MongoidDevise::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users
  resources :users

  match 'posts' => 'post#index'

  root :to => redirect('/users/sign_in')
end