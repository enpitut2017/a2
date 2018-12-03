Rails.application.routes.draw do

  get 'map' => 'static_pages#map'

  get 'contact' => 'static_pages#contact'

  get 'usage' => 'static_pages#usage'

  get 'image' => 'static_pages#image'

  get 'about' => 'static_pages#about'

  get 'comments/new'

  get 'comments/create'

  get "items/sold/:id" => "items#sold"

post "items/comment" => "items#comment"
post "items/destroy" => "items#destroy"
post "items/delete" => "items#delete"

post "items/done" => "items#done"

post "items/show" => "mail_page#home"

  get 'mail_page/home'
  get 'mail_page/done'
  get 'mail_page/done2'
  get 'mail_page/cancel'

  post "items/:id" => "items#show"
  post "items/sold/:id" => "items#sold"
  post "mail_page/home"

  resources :users

  resources :items
  resources :items do
    get 'token/:uuid' => 'items#token'
  end
  resources :comments

  get 'wants/home'
  post 'wants/home' => 'wants#new'
  post 'wants/new' => 'wants#home'
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
