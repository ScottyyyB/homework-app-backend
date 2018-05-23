Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constrains: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      post '/login' => "sessions#create"
      delete '/logout' => "sessions#destroy"
      resources :users, only: [:create, :index]
      resources :classrooms, only: [:create, :destroy, :update, :index, :show] do
        resources :homework, only: [:create, :destroy, :update, :index]
      end
    end
  end
end


