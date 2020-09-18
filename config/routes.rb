require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resource :jobs, only: [:create]
  end

  resources :users, only: [:create] do
    collection do
      resource :json_web_tokens, only: [:create], path: :login
      resource :profile, only: [:show]
    end
  end

  namespace :asteroids do
    resources :near_earth_objects, only: [:index, :show]
    resource :stats, only: [:show], controller: :near_earth_objects_stats
  end

  resource :apod, only: [:show]
end
