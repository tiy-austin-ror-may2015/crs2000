class MeetingsController < ApplicationController

  def index
    # @meetings = Meeting.paginate(:page => params[:page], :per_page => 10)
    company   = Company.find(current_employee.company.id)

    if user_is_admin?
      @meetings = company.meetings
      @meetings = @meetings.paginate(:page => params[:page], :per_page => 10)
    else
      # current_user.invites.meetings
      # @meetings
      # # binding.pry
      # @meetings = @meetings.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    @employee = current_employee
    @attendees = EmployeeMeeting.where(meeting_id: @meeting.id)
    get_occupancy
  end

  def join
    @employee = current_employee
    if EmployeeMeeting.where(meeting_id: params[:id], employee_id: @employee.id).count == 0
      em = EmployeeMeeting.new(meeting_id: params[:id], employee_id: @employee.id)
      em.save
      message = {notice: 'Employee successfully joined!'}
    else
      message = {alert: 'Employee already joined!'}
    end
    redirect_to meeting_path(params[:id]), message
  end

  def get_occupancy
    @max_occupancy = Meeting.find(params[:id]).room.max_occupancy
    attendees_num = EmployeeMeeting.where(meeting_id: params[:id]).count
    @current_occupancy = @max_occupancy - attendees_num
  end

  def new
    @meeting = Meeting.new
    @room_options = Room.company_rooms(current_employee.company_id)
  end

  def edit
    @meeting = Meeting.find(params[:id])
    if employee_signed_in?
      @room_options = Room.company_rooms(current_employee.company_id)
    end
    current_meeting = Meeting.find(params[:id])
    if (!employee_signed_in? || current_employee.id != current_meeting.employee.id)
      redirect_to "/meetings", notice: 'You are not the owner of this meeting!'
    end
  end

  def search
    @meeting_title  = Meeting.search_for('title', params[:search])
                             .paginate(:page => params[:page], :per_page => 10)
    @meeting_agenda = Meeting.search_for('agenda', params[:search])
                             .paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.employee = current_employee
      if @meeting.save
        MeetingMailer.meeting_scheduled(current_employee, @meeting).deliver_now
        redirect_to @meeting, notice: 'Meeting was successfully created.'
      else
        render :new
      end
  end

  def update
    @meeting = Meeting.find(params[:id])
      if @meeting.update(meeting_params)
        MeetingMailer.meeting_changed(current_employee, @meeting).deliver_now
        redirect_to @meeting, notice: 'Meeting was successfully updated.'
      else
        render :edit
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

private
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :agenda, :room_id, :start_time, :end_time)
  end

end
