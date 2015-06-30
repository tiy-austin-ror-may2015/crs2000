class AdminController < ApplicationController
  def dashboard
    if user_is_admin?
      user = current_employee
      @company = user.company
      @total_employees = @company.employees.count
      @total_rooms = @company.rooms.count
      time
      @today_meetings = @company.
    else
      redirect_to :back, alert: "Access Denied"
    end
  end
end
