Rails.application.routes.draw do

  resources :brand_models
  get 'main_page/index'

  resources :light_factories do
    get :autocomplete_factory_brand, :on => :collection
  end
  
  resources :type_furnitures
  resources :products do
    get :autocomplete_type_furniture_name, :on => :collection
    get :autocomplete_factory_brand, :on => :collection
    resources :photos
    resources :size_images
  end

  resources :deliveries
  resources :cities
  resources :styles
  resources :companies
  resources :clients

  devise_for :users, controllers: { registration: "registration" }
  
  resources :factories do
    get "delete"
    get "brand", on: :collection
  end

  resources :clients do
    get "delete"
    get "client", on: :collection
  end
  
  resources :projects do
    resources :statuses
    resources :specifications do
      resources :table_specifications do
        get "edit_image", :edit
        get :autocomplete_product_article, :on => :collection
        get 'update_brand_models', as: 'update_brand_models'
        get 'update_articles', as: 'update_articles'
        get 'update_pipe_article', as: 'update_pipe_article'
        get 'photos', as: 'photos'
        get 'size_images', as: 'size_images'
        get 'discounts', as: 'discounts'
        get 'deliveries', as: 'deliveries'
        get 'packing_sizes', as: 'packing_sizes'
        get 'delivery_data', as: 'delivery_data'
      end
      resources :table_specification_lights do
        get "edit_image", :edit
        get :autocomplete_product_article, :on => :collection
        get '/photos/:id', to: 'photos#show', as: 'photos'        
      end
      get "delete"
    end
      get "delete"
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

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
