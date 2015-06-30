class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def user_is_admin?
    user = current_employee
    user.admin
  end
end
