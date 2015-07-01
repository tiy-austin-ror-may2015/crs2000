class AdminController < ApplicationController
  def dashboard
    if user_is_admin?
      user = current_employee
      @company = user.company
      @total_employees = @company.employees.count
      @total_rooms = @company.rooms.count
      @today_meetings = Meeting.where("start_time >= ? AND start_time < ?",
                                      Time.now.midnight, Time.now.midnight + 1.day)
      @all_future_meetings = Meeting.where("start_time >= ?", Time.now.midnight)
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def index
    @meetings = Meeting.all
    @rooms = Room.all
  end
end
