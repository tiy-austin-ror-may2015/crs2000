class MeetingsController < ApplicationController

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    @employee = current_employee
    get_occupancy
  end

  def join
    ec = EmployeeMeeting.new(meeting_id: params[:id], employee_id: params[:employee_id])
    if EmployeeMeeting.where(meeting_id: params[:id] ).count == 0
      ec.save
      @meeting = Meeting.find(params[:id])
      @employee = Employee.find(params[:employee_id])
      Joinment.joined_confirmation(employee, meeting).deliver_now
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

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
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
