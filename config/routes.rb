Rails.application.routes.draw do

  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books

  get 'view/keyword'
  post 'keyword/search'
  get 'view/form_tag'
  get 'view/form_for'

end
