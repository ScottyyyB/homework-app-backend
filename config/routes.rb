Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get 'ping/index'
    end
  end

  namespace :api do
    namespace :v0 do
      get 'ping/index'
    end
  end
end
