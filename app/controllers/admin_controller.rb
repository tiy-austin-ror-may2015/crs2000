class AdminController < ApplicationController
  before_filter do
    redirect_to root_path unless current_employee && user_is_admin?
  end

  def dashboard
      user                 = current_employee
      @company             = user.company
      @total_employees     = @company.employees.count
      @total_rooms         = @company.rooms.count
      @today_meetings      = Meeting.where("start_time >= ? AND start_time < ?",
                                      Time.now.midnight, Time.now.midnight + 1.day)
      @all_future_meetings = Meeting.where("start_time >= ?", Time.now.midnight)
  end

  def reports_meetings
      @reports_meetings = Meeting.all
  end

  def room_table
      @admin = current_employee
      @rooms = Room.all
      pdf = RoomsPdf.new(Room.all, @admin)
      send_data pdf.render, filename: "room.pdf",
                            type: 'appliciation/pdf',
                            disposition: "inline"
  end

  def meeting_table
      @admin = current_employee
      @meetings = Meeting.all
      pdf = MeetingsPdf.new(Meeting.all, @admin)
      send_data pdf.render, filename: "meeting.pdf",
                            type: 'appliciation/pdf',
                            disposition: "inline"
  end

  def reports_rooms
      @reports_rooms = Room.all
      @top_rooms = Meeting.joins(:room).group(:room).order('count_all DESC').limit(3).count
  end

  def busiest_employees
    @busiest_employees = Meeting.joins(:employee).group(:employee).order('count_all DESC').limit(3).count
  end

  def add_branding
      @company = current_employee.company
      render 'companies/_form'
  end
end

