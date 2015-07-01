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

  def index
    @meetings = Meeting.all
    @rooms = Room.all
  end

  def room_table
    @rooms = Room.all
     respond_to do |format|
      format.html
      format.pdf do
        pdf = RoomsPdf.new(Room.all)
        send_data pdf.render, filename: "room.pdf",
                              type: 'appliciation/pdf',
                              disposition: "inline"
      end
    end
  end
end
