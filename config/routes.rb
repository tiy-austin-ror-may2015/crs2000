Rails.application.routes.draw do
  resources :meetings
  post 'meetings/join/:id', to: 'meetings#join', as: :join_employee
  devise_for :employees
  get 'employees/:id', to: 'employees#show', as: 'employee'
  get 'employees', to: 'employees#index', as: 'employees'
  get 'employees/:id/edit', to: 'employees#edit', as: 'edit_employee'
  patch 'employees/:id(.:format)', to: 'employees#update', as: 'patch_employee'
  resources :rooms
  resources :companies
  root to:'rooms#index'
  get '/search/meetings', to: 'meetings#search'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
