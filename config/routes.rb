Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :ping, only: [:index], constrains: { format: 'json' }
    end
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end

