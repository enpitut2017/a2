Rails.application.routes.draw do


  get 'contact_page/home'

  get 'contact_page/done'

  get 'comments/new'

  get 'comments/create'

post "items/comment" => "items#comment"

  get 'mail_page/home'
  get 'mail_page/done'


  resources :users

  resources :items
  resources :comments
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
