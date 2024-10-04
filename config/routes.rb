Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :menus, only: [:index, :show]
      resources :restaurants, only: [:index, :show]
    end
  end
end
