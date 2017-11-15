Rails.application.routes.draw do
  root 'items#index'

  resources :items do
    member do
      get 'auth'
      post 'auth'
    end
  end
end
