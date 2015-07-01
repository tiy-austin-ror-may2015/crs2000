class AdminController < ApplicationController
  def dashboard
    if user_is_admin?
      user = current_employee
      @company = user.company
      @total_employees = @company.employees.count
      @total_rooms = @company.rooms.count
      today = Time.now.strftime("%m/%d/%Y").gsub('/', '').to_i
      @today_meetings = Meeting.where("start_time >= ? AND start_time <= ?",
                                      Time.now.midnight - 1.day, Time.now.midnight)
      @all_future_meetings = Meeting.where("start_time >= ?", Time.now.midnight - 1.day)
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def reports_meetings
    @reports_meetings = Meeting.all
  end

  def room_table
    @rooms = Room.all
     respond_to do |format|
      format.html do

      end
      format.pdf do
        pdf = RoomsPdf.new(Room.all)
        send_data pdf.render, filename: "room.pdf",
                              type: 'appliciation/pdf',
                              disposition: "inline"
     end
    end
  end

  def reports_rooms
    @reports_rooms = Room.all
    @top_rooms = Meeting.joins(:room).group(:room).order('count_all DESC').limit(3).count
  end

  def busiest_employees
    @busiest_employees = Meeting.joins(:employee).group(:employee).order('count_all DESC').limit(3).count
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

