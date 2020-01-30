Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, param: :filter, only: [:index, :show]
    end
  end
end
