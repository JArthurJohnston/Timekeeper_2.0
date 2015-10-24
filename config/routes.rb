Rails.application.routes.draw do
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

  resources :users do
    resources :statements_of_work
    resources :story_cards, only: :new
    resources :projects do
      resources :story_cards
    end
    resources :timesheets do
      resources :activities
    end
  end

  match 'users/:user_id/projects/:project_id/story_cards/select' => 'story_cards#select',
        via: :get,
        as: 'user_project_story_card_select'
  match 'users/:user_id/timesheet/:timesheet_id/add_activity' => 'activities#new_for_timesheet',
        via: :get,
        as: 'new_activity_for_timesheet'

  match 'users/:user_id/timesheet/:timesheet_id/story_cards/:story_card_id/create_activity_for_timesheet' => 'activities#create_for_timesheet',
        via: :post,
        as: 'create_activity_for_timesheet'
  match 'users/:user_id/timesheet/:timesheet_id/add_story_card_with_activity' => 'story_cards#new_with_activity',
        via: :get,
        as: 'new_story_card_for_activity'
  match 'users/:user_id/timesheet/:timesheet_id/create_story_card_with_activity' => 'story_cards#create_with_activity',
        via: :post,
        as: 'create_story_card_for_activity'

end
