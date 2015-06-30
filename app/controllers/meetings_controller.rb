class MeetingsController < ApplicationController

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /meetings/1
  # GET /meetings/1.json
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
      @meeting = Meeting.find(params[:id])
      @employee = current_employee
      mm = MeetingMailer.meeting_scheduled(@employee, @meeting).deliver_later
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
  end

  # GET /meetings/1/edit
  def edit
  end

  def search
    @meeting_title  = Meeting.all.where("title LIKE ?", "%" + params[:search] + "%")
                                 .paginate(:page => params[:page], :per_page => 10)
    @meeting_agenda = Meeting.all.where("agenda LIKE ?", "%" + params[:search] + "%")
                                 .paginate(:page => params[:page], :per_page => 10)
    @meeting_rooms  = Room.all.where("name LIKE ?", "%" + params[:search] + "%")
                                 .paginate(:page => params[:page], :per_page => 10)
  end
  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        MeetingMailer.meeting_scheduled(current_employee, @meeting).deliver_now
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        MeetingMailer.meeting_changed(current_employee, @meeting).deliver_now
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    MeetingMailer.meeting_cancelled(current_employee, @meeting).deliver_now
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meeting_params
    params.require(:meeting).permit(:title, :agenda, :start_time, :end_time)
  end
end
