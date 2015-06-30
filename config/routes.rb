Rails.application.routes.draw do
  resources :meetings
  devise_for :employees
  resources :rooms
  resources :companies


  root to:'rooms#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
