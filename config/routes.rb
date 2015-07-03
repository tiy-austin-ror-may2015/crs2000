# RAKE ROUTES IS AT THE BOTTOM OF THE PAGE

Rails.application.routes.draw do

  devise_for :employees


  authenticate :employee do

    resources :rooms
    resources :companies, except: :index
    get 'admin/invitations/show', to: "invitations#show"
    delete 'invitations/:id', to: "invitations#destroy", as: 'invitation'
    resources :meetings

  #ADMIN (Will / Alex)
  get 'admin/dashboard', to: 'admin#dashboard', as: 'dashboard'
  get 'admin/reports_meetings', to: 'admin#reports_meetings'
  get 'admin/reports_rooms', to: 'admin#reports_rooms'
  get 'admin/reports_rooms/top_rooms', to: 'admin#top_rooms'
  get 'admin/busiest_employees', to: 'admin#busiest_employees'
  get 'admin/add_branding', to: 'admin#add_branding'
  get 'admin', to: 'admin#dashboard'
  get 'admin/room_report', to: 'admin#room_table'
  get 'admin/meeting_report', to: 'admin#meeting_table'

  #EMPLOYEES
  get 'employees/:id', to: 'employees#show', as: 'employee'
  get 'employees', to: 'employees#index', as: 'employees'
  get 'employees/:id/edit', to: 'employees#edit', as: 'edit_employee'
  patch 'employees/:id(.:format)', to: 'employees#update', as: 'patch_employee'
  get '/search/employees', to: 'employees#employee_search'


  post 'meetings/:meeting_id/invite/:employee_id', to: 'meetings#invite', as: 'send_invitation'
  post 'meetings/join/:id', to: 'meetings#join', as: :join_employee
  post '/invitations', to: 'invitations#create'

  get '/search/meetings', to: 'meetings#search'
  get '/search/rooms', to: 'rooms#search'
  get '/search_advance/rooms', to: 'rooms#search_advance'
  root to:'meetings#index'
  end
end

#                        Prefix Verb   URI Pattern                                         Controller#Action
#          new_employee_session GET    /employees/sign_in(.:format)                        devise/sessions#new
#              employee_session POST   /employees/sign_in(.:format)                        devise/sessions#create
#      destroy_employee_session DELETE /employees/sign_out(.:format)                       devise/sessions#destroy
#             employee_password POST   /employees/password(.:format)                       devise/passwords#create
#         new_employee_password GET    /employees/password/new(.:format)                   devise/passwords#new
#        edit_employee_password GET    /employees/password/edit(.:format)                  devise/passwords#edit
#                               PATCH  /employees/password(.:format)                       devise/passwords#update
#                               PUT    /employees/password(.:format)                       devise/passwords#update
#  cancel_employee_registration GET    /employees/cancel(.:format)                         devise/registrations#cancel
#         employee_registration POST   /employees(.:format)                                devise/registrations#create
#     new_employee_registration GET    /employees/sign_up(.:format)                        devise/registrations#new
#    edit_employee_registration GET    /employees/edit(.:format)                           devise/registrations#edit
#                               PATCH  /employees(.:format)                                devise/registrations#update
#                               PUT    /employees(.:format)                                devise/registrations#update
#                               DELETE /employees(.:format)                                devise/registrations#destroy
#                    invitation POST   /meetings/invite/:meeting_id/:employee_id(.:format) meetings#invite
#                      employee GET    /employees/:id(.:format)                            employees#show
#                     employees GET    /employees(.:format)                                employees#index
#                 edit_employee GET    /employees/:id/edit(.:format)                       employees#edit
#                patch_employee PATCH  /employees/:id(.:format)                            employees#update
#               search_meetings GET    /search/meetings(.:format)                          meetings#search
#                  search_rooms GET    /search/rooms(.:format)                             rooms#search
#          search_advance_rooms GET    /search_advance/rooms(.:format)                     rooms#search_advance
#              search_employees GET    /search/employees(.:format)                         employees#employee_search
#                         rooms GET    /rooms(.:format)                                    rooms#index
#                               POST   /rooms(.:format)                                    rooms#create
#                      new_room GET    /rooms/new(.:format)                                rooms#new
#                     edit_room GET    /rooms/:id/edit(.:format)                           rooms#edit
#                          room GET    /rooms/:id(.:format)                                rooms#show
#                               PATCH  /rooms/:id(.:format)                                rooms#update
#                               PUT    /rooms/:id(.:format)                                rooms#update
#                               DELETE /rooms/:id(.:format)                                rooms#destroy
#                     companies GET    /companies(.:format)                                companies#index
#                               POST   /companies(.:format)                                companies#create
#                   new_company GET    /companies/new(.:format)                            companies#new
#                  edit_company GET    /companies/:id/edit(.:format)                       companies#edit
#                       company GET    /companies/:id(.:format)                            companies#show
#                               PATCH  /companies/:id(.:format)                            companies#update
#                               PUT    /companies/:id(.:format)                            companies#update
#                               DELETE /companies/:id(.:format)                            companies#destroy
#                   admin_index GET    /admin(.:format)                                    admin#index
#                               POST   /admin(.:format)                                    admin#create
#                     new_admin GET    /admin/new(.:format)                                admin#new
#                    edit_admin GET    /admin/:id/edit(.:format)                           admin#edit
#                         admin GET    /admin/:id(.:format)                                admin#show
#                               PATCH  /admin/:id(.:format)                                admin#update
#                               PUT    /admin/:id(.:format)                                admin#update
#                               DELETE /admin/:id(.:format)                                admin#destroy
#                     dashboard GET    /admin/dashboard(.:format)                          admin#dashboard
#        admin_reports_meetings GET    /admin/reports_meetings(.:format)                   admin#reports_meetings
#           admin_reports_rooms GET    /admin/reports_rooms(.:format)                      admin#reports_rooms
# admin_reports_rooms_top_rooms GET    /admin/reports_rooms/top_rooms(.:format)            admin#top_rooms
#       admin_busiest_employees GET    /admin/busiest_employees(.:format)                  admin#busiest_employees
#                      meetings GET    /meetings(.:format)                                 meetings#index
#                               POST   /meetings(.:format)                                 meetings#create
#                   new_meeting GET    /meetings/new(.:format)                             meetings#new
#                  edit_meeting GET    /meetings/:id/edit(.:format)                        meetings#edit
#                       meeting GET    /meetings/:id(.:format)                             meetings#show
#                               PATCH  /meetings/:id(.:format)                             meetings#update
#                               PUT    /meetings/:id(.:format)                             meetings#update
#                               DELETE /meetings/:id(.:format)                             meetings#destroy
#                join_employees POST   /meetings/join/:id(.:format)                        meetings#join
#                          root GET    /                                                   rooms#index
