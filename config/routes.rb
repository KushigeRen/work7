Rails.application.routes.draw do
  root to: 'home#home'
  get 'users/profile',to: 'users#profile'
  get 'users/edit_profile',to: 'users#edit_profile'
  post 'reservations/comfirm',to: 'reservations#comfirm'
  get 'reservations/own',to: 'reservations#own'
  get 'rooms/search',to: 'rooms#search'
  get 'rooms/own',to: 'rooms#own'
  devise_for :users
  resources :users
  resources :reservations
  resources :rooms
end
