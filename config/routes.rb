Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      resource :json_web_tokens, only: [:create], path: :login
      resource :profile, only: [:show]
    end
  end
  namespace :admin do
    resource :jobs, only: [:create]
  end
end
