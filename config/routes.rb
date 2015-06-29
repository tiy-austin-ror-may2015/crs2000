Rails.application.routes.draw do
  resources :meetings
  devise_for :employees
  resources :rooms
  resources :companies

  root to:'rooms#index'
  get '/search/meetings', to: 'meetings#search'
end
