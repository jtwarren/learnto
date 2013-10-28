Learnto::Application.routes.draw do

  resources :users do
    collection do
      get "sign_in"
    end
  end
  resources :skills do
    collection do
      get "send_request"
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  get "inquire" => "users#inquire", :as => "user_inquire"
  post "inquire" => "users#inquire", :as => "user_inquire_post"

  get 'auth/:provider/callback' => 'sessions#create', :as => "social_sign_in"
  get 'auth/failure' => redirect('/')

  get 'home' => 'static_pages#home', as: 'home'
  get "about" => 'static_pages#about', :as => "about"
  
  get "registration/register", as: 'register'
  patch "registration/update", as: 'update_registration'

  get "messaging/inbox", as: 'inbox'
  post "messaging/reply", as: 'reply'
  get "messaging/conversation", as: 'conversation'

  post "skills/send_request", as: 'send_request'

  root 'skills#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
