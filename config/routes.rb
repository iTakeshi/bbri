Bbri::Application.routes.draw do

  get '/parts/register', to: 'parts#new'
  post '/parts/register', to: 'parts#create'
  get '/search', to: 'parts#search'
  get '/parts/:part_identifier', to: 'parts#show'
  get '/parts/team_parts/:team_name', to: 'parts#team_parts'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/confirm/:user_auth_token', to: 'users#confirm'
  get '/profile', to: 'users#edit'
  put '/profile', to: 'users#update'
  get '/profile/password', to: 'users#edit_password'
  post '/profile/password', to: 'users#update_password'
  get '/signout', to: 'users#signout'
  delete '/signout', to: 'users#delete'
  get '/reset_password', to: 'users#reset_password'
  post '/reset_password', to: 'users#send_new_password'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#delete'

  match '/parts/:part_identifier/user_review', to: 'reviews#create_or_update'

  get '/reviews', to: 'reviews#index'
  get '/reviews/:review_id/good', to: 'reviews#good'

  get '/teams', to: 'teams#index'

  root to: 'ranking#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
