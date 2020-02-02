Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :merchants, module: :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          resources :items, only: :index
        end
      end

      scope :items, module: :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :items, only: [:index, :show] do
        # it passes regardless of whether ot not it's index or show? why? ^^^^
        scope module: :items do
          resources :merchant, only: :index
        end
      end

      resources :invoices, only: [:show, :index]
    end
  end
end
