class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_is_admin?
    if current_employee
      user = current_employee
      user.admin
    end
  end

  helper_method :user_is_admin?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name << :company_id
  end
end
