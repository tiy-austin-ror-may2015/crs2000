Rails.application.routes.draw do
  resources :meetings
  devise_for :employees
  resources :rooms
  resources :companies

  root to:'application#index'

end
