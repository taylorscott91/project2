Rails.application.routes.draw do
  root to: 'groups#index'

  resources :groups do
    resources :games
  end
end
