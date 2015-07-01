class AdminController < ApplicationController
  def dashboard
    if user_is_admin?
      user                 = current_employee
      @company             = user.company
      @total_employees     = @company.employees.count
      @total_rooms         = @company.rooms.count
      @today_meetings      = Meeting.where("start_time >= ? AND start_time < ?",
                                      Time.now.midnight, Time.now.midnight + 1.day)
      @all_future_meetings = Meeting.where("start_time >= ?", Time.now.midnight)
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def reports_meetings
    @reports_meetings = Meeting.all
  end

  def reports_rooms
    @reports_rooms = Room.all
    @top_rooms = Meeting.joins(:room).group(:room).order('count_all DESC').limit(3).count
  end

  def busiest_employees
    @busiest_employees = Meeting.sort_by
  end

  def add_branding
    if user_is_admin?
      @company = current_employee.company
      render 'companies/_form'
    else
      redirect_to root_path, alert: "Access Denied"
    end
  end

end
