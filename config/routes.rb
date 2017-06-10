Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      resource :tokens, only: [:create], path: :login
    end
  end
end
