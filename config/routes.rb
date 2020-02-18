Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'revenue#index'
      end

      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          resources :items, only: :index
          resources :invoices, only: :index
        end
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :items, only: [:index, :show] do
        scope module: :items do
          resources :merchant, only: :index
        end
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :invoices, only: [:show, :index]
    end
  end
end
