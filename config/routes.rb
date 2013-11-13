Learnto::Application.routes.draw do

  resources :users do
    collection do
      get "requests"
    end
  end

  resources :skills do
    resources :lessons
  end

  resources :lessons do
    member do
      get "approve"
      get "ignore"
      get "complete"
    end
  end

  resources :conversations do
    collection do
      get "inbox"
      post "reply"
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  get 'auth/:provider/callback' => 'sessions#create', :as => "social_sign_in"
  get 'auth/failure' => redirect('/')

  # get 'home' => 'static_pages#home', as: 'home'
  get "about" => 'static_pages#about', :as => "about"
  
  get "registration/register", as: 'register'
  patch "registration/update", as: 'update_registration'

  post "skills/send_request", as: 'send_request'

  root 'skills#index'
end
