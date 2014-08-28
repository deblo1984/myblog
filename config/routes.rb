Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'

  scope '/admin' do
    devise_for :users, :skip => [:sessions], :controllers => {:registrations => "registrations", :sessions => "sessions"}
    as :user do
      get 'daftar' => 'registrations#new', :as => :new_user_registrations
      post 'daftar' => 'registrations#create', :as => :user_registrations
      get 'login' => 'sessions#new', :as => :new_user_session
      post 'login' => 'sessions#create', :as => :user_session
      delete 'logout' => 'sessions#destroy', :as => :destroy_user_session 
    end
  end

  namespace :admin do
    root :to => "dashboard#index"
    resources :categories
    resources :articles
      get 'articles/browse/:published', to: 'articles#browse', as: 'articles_browse'
      get 'autocomplete_tags', to: 'articles#autocomplete_tags', as: 'autocomplete_tags'
    resources :profiles
    resources :users
  end
  

  root :to => 'posts#index'
  resources :posts, only: [:index, :show] do 
    resources :comments, only: [:create]
  end
  resources :pages
  get 'tags/:tag', to: 'posts#tagged', :as => 'tags'
  get 'sitemap.:format', to: 'sitemap#index', as: 'sitemap', :defaults => {:format => :xml}
  get 'category/:id', to: 'home#by_category', as: 'category'

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
