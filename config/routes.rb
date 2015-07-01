Rails.application.routes.draw do
  resources :meetings
  post 'meetings/join/:id', to: 'meetings#join', as: :join_employee
  devise_for :employees
  get 'employees/:id', to: 'employees#show', as: 'employee'
  get 'employees', to: 'employees#index', as: 'employees'
  get 'employees/:id/edit', to: 'employees#edit', as: 'edit_employee'
  patch 'employees/:id(.:format)', to: 'employees#update', as: 'patch_employee'
  get '/search/meetings', to: 'meetings#search'
  get '/search/rooms', to: 'rooms#search'
  get '/search_advance/rooms', to: 'rooms#search_advance'
  get '/search/employees', to: 'employees#search'

  resources :rooms
  resources :companies
  get 'admin/dashboard', to: 'admin#dashboard', as: 'dashboard'
  resources :admin
  root to:'rooms#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
