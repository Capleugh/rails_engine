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
    end
  end
end
