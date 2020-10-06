Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
