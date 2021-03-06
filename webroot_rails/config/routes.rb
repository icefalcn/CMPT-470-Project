Rails.application.routes.draw do
  # root 'movie#index'
  resources :users
  root :to => redirect('/index')
  get 'index' => 'movies#index'
  get 'movies/search' => 'movies#search'
  get 'movies/:id' => 'movies#show', as: :movie
  post 'movies/search' => 'movies#search'
  post 'movies' => 'movies#create'
  
  post 'movies/:id/upvote' => 'movies#upvote'
  post 'movies/:id/downvote' => 'movies#downvote'

  get '/movies/:id/edit' => 'movies#edit', as: :edit_movie 
  patch '/movies/:id' => 'movies#update'
  # post '/movies/:id' => 'movies#update'


  get 'actors' => 'actors#index'
  get 'actors/:id' => 'actors#show', as: :actor

  get '/login' => 'users#login'
  post '/login' => 'movies#index'
  get 'register' => 'users#register'
  post '/register' => 'users#login'


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
