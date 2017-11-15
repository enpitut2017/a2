Rails.application.routes.draw do
  get 'mail_page/home'
  get 'mail_page/done'

  resources :users
  resources :items
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
