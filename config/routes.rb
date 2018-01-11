Rails.application.routes.draw do

  get 'map' => 'static_pages#map'

  get 'contact' => 'static_pages#contact'

  get 'usage' => 'static_pages#usage'

  get 'comments/new'

  get 'comments/create'

  get "items/sold/:id" => "items#sold"

post "items/comment" => "items#comment"
post "items/destroy" => "items#destroy"

  get 'mail_page/home'
  get 'mail_page/done'

  post "items/:id" => "items#show"
  post "items/sold/:id" => "items#sold"

  resources :users

  resources :items
  resources :comments
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
