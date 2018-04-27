Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'ping/index'
    end
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
