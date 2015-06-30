class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
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
    @all_rooms = Room.where(company_id: current_employee.company_id).pluck(:name)
    current_meeting = Meeting.find(params[:id])
    # render json: current_meeting
    if (current_employee.id != current_meeting.employee.id)
      redirect_to meeting, notice: 'You are not the owner of this meeting!'
    end
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.employee_id = current_employee.id
    @meeting.room_id = Room.where(company_id: current_employee.company_id, name: params[:name])

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
