class MeetingsController < ApplicationController
  # before_action :check_employee_overlap!, only: [:join, :create]

  def index
    @meetings = Meeting.paginate(:page => params[:page], :per_page => 10)
    # company   = Company.find(current_employee.company.id)
    # @meetings = company.meetings
    # binding.pry
    # @meetings = Meeting.send_meetings(@meetings)

    # @meetings.paginate(:page => params[:page], :per_page =>10)
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
    capacity  = Meeting.capacity(params[:id])
    attending = EmployeeMeeting.attending(params[:id])
    @current_occupancy = capacity - attending
  end

  def new
    @meeting = Meeting.new
    @room_options = Room.company_rooms(current_employee.company_id)
  end

  def edit
    @meeting = Meeting.find(params[:id])
    if employee_signed_in?
      all_rooms = Room.where(company_id: current_employee.company_id)
      binding.pry
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
    if room_is_available?(@meeting)
      @meeting.employee = current_employee
        if @meeting.save
          MeetingMailer.meeting_scheduled(current_employee, @meeting).deliver_now
          redirect_to @meeting, notice: 'Meeting was successfully created.'
        else
          render :new
        end
    else
      flash[:alert] = "That room is already occupied during that time."
      redirect_to :back
  end

  def update
    @meeting = Meeting.find(params[:id])
    if room_is_available?(@meeting)
      if @meeting.update(meeting_params)
        MeetingMailer.meeting_changed(current_employee, @meeting).deliver_now
        redirect_to @meeting, notice: 'Meeting was successfully updated.'
      else
        render :edit
      end
    else
      flash[:alert] = "That room is already occupied during that time."
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

  # def check_employee_overlap!
  #   @attendees = EmployeeMeeting.where(meeting_id: params[:id])
  #   @attendees.each do |attendee|
  #     @begin_time = attendee.meeting.start_time
  #     @finish_time = attendee.meeting.end_time
  #   end
  #   if @meeting.start_time< Time.now
  #     redirect_to @meeting, alert: 'You are already in another meeting.'
  #   end
  # end



  private
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :agenda, :room_id, :start_time, :end_time)
  end

end
