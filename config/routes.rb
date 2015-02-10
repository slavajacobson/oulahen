Oulahen::Application.routes.draw do
  resources :condo_profiles do
    collection do
      get 'get_coordinates', as: 'get_coordinates'
      get 'search(/:q)', action: 'search', as: 'search'
      get 'view_all', as: 'view_all'
    end
  end

  resources :custom_fields

  resources :team_members do
    collection do
      post 'add_custom_field', as: 'add_custom_field'
      get 'about_us'
    end
  end

  resources :slide_show_images do
     collection do
        post 'update_order', as: 'update_order' 
     end
      
  end

  resources :photos do
    collection do
      post 'manipulate', as: 'manipulate'
    end
  end
  

  resources :listings do
    collection do
      get 'disable_feature', as: 'disable_feature'
      get 'residential'
      get 'commercial'
      get 'transactions(/:id)' => 'listings#transactions'
    end

  end

  match "/contact-us-form-sendmail" => "main#contact_us_form", as: 'contact_us_sendmail', via:[:post]
  get "admin" => "listings#index", as: 'admin'
  devise_for :users
  get "/pages/*id" => 'pages#show', :as => :view, :format => false
  #root 'pages#index'

  root 'pages#index'

  get "/accaday" => "pages#accaday"
  #match "/" => redirect("/pages/index"), via: [:get, :post]

  match "/404", :to => "errors#not_found", via: [:get, :post]

  # namespace :admin do
  #   root to: "listings#index"
  # end
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
