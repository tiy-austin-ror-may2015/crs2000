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

  resources :rooms
  resources :companies

# ADMIN
  get 'admin/reports_meetings', to: 'admin#reports_meetings'
  get 'admin/reports_rooms', to: 'admin#reports_rooms'
  get 'admin/reports_rooms/top_rooms', to: 'admin#top_rooms'

  root to:'rooms#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end
