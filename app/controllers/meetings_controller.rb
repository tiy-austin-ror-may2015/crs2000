class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @all_rooms = Room.where(company_id: current_employee.company_id).pluck(:name)
  end

  # GET /meetings/1/edit
  def edit
    if employee_signed_in?
    @all_rooms = Room.where(company_id: current_employee.company_id).pluck(:name)
    end
    current_meeting = Meeting.find(params[:id])
    if (!employee_signed_in? || current_employee.id != current_meeting.employee.id)
      redirect_to "/meetings", notice: 'You are not the owner of this meeting!'
    end
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
    @meeting.employee_id = current_employee.id
    @meeting.room_id = Room.where(company_id: current_employee.company_id, name: params[:name])

    respond_to do |format|
      if @meeting.save
        MeetingMailer.meeting_scheduled(current_employee, @meeting).deliver_later
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
        MeetingMailer.meeting_changed(current_employee, @meeting).deliver_later
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
    current_meeting = Meeting.find(params[:id])
    if (!employee_signed_in? || current_employee.id != current_meeting.employee.id)
      redirect_to "/meetings", notice: 'You are not the owner of this meeting!'
    else
    MeetingMailer.meeting_cancelled(current_employee, @meeting).deliver_later
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
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
