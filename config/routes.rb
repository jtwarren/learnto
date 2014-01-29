Learnto::Application.routes.draw do

  get "networks/show"
  resources :sessions, only: [:new, :create, :destroy]

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get 'auth/:provider/callback' => 'sessions#create', :as => "social_sign_in"
  get 'auth/failure' => redirect('/')

  get "healthbox" => "networks#show", defaults: {id: 5}
  get "bgsa" => "networks#bgsa", defaults: {id: 2}
  get "startlabs" => "networks#startlabs", defaults: {id:}
  get "healthbox" => "networks#show", defaults: {id: 5}
  get "startiap" => "networks#show", defaults: {id: 7}


  get "about" => 'static_pages#about', :as => "about"
  get "guidelines" => 'static_pages#guidelines', :as => "guidelines"
  get "team" => 'static_pages#team', :as => "team"
  get "whyteach" => 'static_pages#whyteach', :as => "whyteach"

  get "registration/register", as: 'register'
  patch "registration/update", as: 'update_registration'

  root 'skills#index'

  get 'networks/:id' => 'networks#show'
  get 'networks/:id/join' => 'networks#join', as: 'join_network'

  resources :users do
    collection do
      # get "requests"
    end
  end

  resources :reviews

  get "networks/:id" => "networks#show", :as => "network"
  
  resources :events do
    member do 
      post 'attend'
    end
  end

  resources :skills do
    collection do
      get 'networks'
    end
    resources :lessons
    member do
      get "remove"
    end
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
end
