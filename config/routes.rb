Rails.application.routes.draw do

  namespace :admins do
    get 'top/index'
    resources :users do
      get "search", on: :collection
    end
    resources :articles do
      get "search", on: :collection
    end
  end
  resources :blogs do
    patch "like", "unlike", on: :member
    get "liked", on: :member
    get "search", on: :collection
    resources :blog_images, only: [:destroy]
  end

  resources :articles do
    get "search", on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  get "login" => "top#login"
  get "signin" => "top#signin"
  #get "about" => "top#about"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  namespace :admins do
    root "top#index"
  end

  resources :users, only: [:index, :show, :new, :create] do
    get "search", on: :collection
    resources :blogs, only: [:index]
    member do
      get :following, :followers
    end
  end

  resource :session,  only: [:create, :destroy, :login]
  resource :account,  only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]
  resources :messages, only: [:show, :create]
  namespace :api do
    resources :messages, only: :index, defaults: { format: 'json' }
  end
  resources :relationships do
    collection do
      get :followers, :followed, :matched
    end
  end
end
