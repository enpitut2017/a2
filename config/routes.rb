Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

post "items/comment" => "items#comment"

  resources :items
  resources :comments
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
