class MeetingsController < ApplicationController

  def index
    @company = current_employee.company
    if current_employee
        company   = Company.find(current_employee.company.id)
      if user_is_admin?
        @meetings = current_employee.company.meetings.today_forward
        @meetings = current_employee.company.meetings.paginate(:page => params[:page], :per_page => 10)
      else
        @meetings = current_employee.company.meetings.today_forward.where("private = false")
        @meetings = current_employee.company.meetings.paginate(:page => params[:page], :per_page => 10)
      end
    else
      redirect_to root_path, alert: "Please Log In"
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    # if user_is_admin? && @meeting.room.company.id == current_employee.company.id ||
    #    @meeting.invitations.exists?(employee_id: current_employee.id) ||
    #    @meeting.employee_id == current_employee.id
      @current_employee = current_employee
      @attendees = EmployeeMeeting.where(meeting_id: @meeting.id).map{|em| em.employee}
      @invitees = Employee.where(company_id: current_employee.company_id) - @attendees
      @meeting_owner = (@meeting.employee_id == @current_employee.id)
      get_occupancy
    # else
    #   redirect_to :back, alert: "Access Denied"
    # end
  end

  def get_occupancy
    @max_occupancy = Meeting.find(params[:id]).room.max_occupancy
    attendees_num = EmployeeMeeting.where(meeting_id: params[:id]).count
    @current_occupancy = @max_occupancy - attendees_num
  end

  def invite
      if Invitation.where(meeting_id: params[:meeting_id], employee_id: params[:employee_id]).count == 0
        invitation = Invitation.new(meeting_id: params[:meeting_id], employee_id: params[:employee_id])
        invitation.save
        @employee = Employee.find(params[:employee_id])
        @meeting = Meeting.find(params[:meeting_id])
        MeetingMailer.invited_to_meeting(@employee, @meeting).deliver_now
          message = {notice: 'invitation successfully sent!'}
        else
          message = {alert: 'invitation has been already sent!'}
        end
      redirect_to meeting_path(params[:meeting_id]), message
  end

  def join
    @current_employee = current_employee
    if EmployeeMeeting.where(meeting_id: params[:id], employee_id: @current_employee.id).count == 0
      meeting = Meeting.find(params[:id])
      if meeting_overlap? (meeting)
        message = {alert: 'You own or are already in another meeting at this time.'}
      else
        em = EmployeeMeeting.new(meeting_id: params[:id], employee_id: @current_employee.id)
        em.save
        message = {notice: 'Employee successfully joined!'}
      end
    else
      message = {alert: 'Employee already joined!'}
    end
    redirect_to meeting_path(params[:id]), message
  end

  def get_occupancy
    @max_occupancy = Meeting.capacity(params[:id])
    attending = EmployeeMeeting.attending(params[:id])
    @current_occupancy = @max_occupancy  - attending
  end

  def new
    @meeting = Meeting.new
    @room_options = Room.company_rooms(current_employee.company_id)
  end

  def edit
    @meeting = Meeting.find(params[:id])
    if employee_signed_in?
      all_rooms = Room.where(company_id: current_employee.company_id)
      @room_options = all_rooms.map { |room| [room.name, room.id] }
    end
    current_meeting = Meeting.find(params[:id])
    if (!employee_signed_in? || current_employee.id != current_meeting.employee.id)
      redirect_to "/meetings", notice: 'You are not the owner of this meeting!'
    end
  end

  def search
    @meeting_results = Meeting.search_for(params[:search])
                              .paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @meeting = Meeting.new(meeting_params)
    if room_is_available?(@meeting) && no_meeting_overlap?(@meeting)
      @meeting.employee = current_employee
        if @meeting.save
          MeetingMailer.meeting_scheduled(current_employee, @meeting).deliver_now
          redirect_to @meeting, notice: 'Meeting was successfully created.'
        else
          render :new
        end
    else
      flash[:alert] = "The room is occupied or you have a meeting during that time."
      redirect_to :back
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    if room_is_available?(@meeting) && no_meeting_overlap?(@meeting)
      if @meeting.update(meeting_params)
        MeetingMailer.meeting_changed(current_employee, @meeting).deliver_now
        redirect_to @meeting, notice: 'Meeting was successfully updated.'
      else
        render :edit
      end
    else
      flash[:alert] = "The room is occupied or you have a meeting during that time."
      redirect_to :back
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    current_meeting = Meeting.find(params[:id])
    if (!employee_signed_in? || current_employee.id != current_meeting.employee.id)
      redirect_to "/meetings", notice: 'You are not the owner of this meeting!'
    else
      MeetingMailer.meeting_cancelled(current_employee, @meeting).deliver_now
      @meeting.destroy
      redirect_to meetings_url, notice: 'Meeting was successfully destroyed.'
    end
  end

# QUESTIONS? TALK TO WILL
  def reports_meetings
    @reports_meetings = Meeting.all
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :agenda, :room_id, :start_time, :end_time, :private)
  end

end
