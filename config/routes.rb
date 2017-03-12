Rails.application.routes.draw do
  root to: 'groups#index'
  # Good setup of root route and nesting resources
  resources :groups do
    resources :games
  end
end
