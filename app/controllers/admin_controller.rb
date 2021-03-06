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

  def room_table
      @rooms = Room.all
      pdf = RoomsPdf.new(Room.all)
      send_data pdf.render, filename: "room.pdf",
                            type: 'appliciation/pdf',
                            disposition: "inline"
  end

  def meeting_table
      @meetings = current_company.meetings.all
      pdf = MeetingsPdf.new(Meeting.all)
      send_data pdf.render, filename: "meeting.pdf",
                            type: 'appliciation/pdf',
                            disposition: "inline"
  end

  def reports_meetings
      @reports_meetings = Meeting.all
  end

  def reports_rooms
      @reports_rooms = Room.all
      @top_rooms = Meeting.joins(:room).group(:room).order('count_all DESC').limit(3).count
  end

  def busiest_employees
    @busiest_employees = Meeting.joins(:employee).group(:employee).order('count_all DESC').limit(3).count
    # @busiest_employee = Employee.find(params[:id])
  end

  def show
    @busiest_employee = Employee.find(params[:id])
  end


  def add_branding
      @company = current_company
      render 'companies/_form'
  end
end

