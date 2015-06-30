class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    update_rooms
    sort_by = params.fetch("sort_by", "created_at")
    sort_dir = params.fetch("sort_dir", "ASC")
    search_query = params.fetch("search_query", {})
    name = search_query.fetch("name", "")
    max_occupancy = search_query.fetch("max_occupancy", "0")
    room_number = search_query.fetch("room_number", "%%")
    meetings_count = search_query.fetch("meetings_count", "%%")
    available = search_query.fetch("available", "%%")
    @rooms = Room.where("lower(name) LIKE lower('%#{name}%') AND
                          max_occupancy >= #{max_occupancy} AND
                          CAST(room_number AS TEXT) LIKE '#{room_number}' AND
                          CAST(meetings_count AS TEXT) LIKE '#{meetings_count}' AND
                          CAST(available AS TEXT) LIKE '#{available}'").order("#{sort_by} #{sort_dir}").paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    room = Room.find(params[:id])
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @all_rooms = Room.where(company_id: current_employee.company_id).pluck(:name)
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
 def create
  if user_is_admin?

      user = current_employee
      @company = user.company
      @room    = @company.rooms.build

      @room[:name]          = params[:room][:name]
      @room[:location]      = params[:room][:location]
      @room[:room_number]   = params[:room][:room_number]
      @room[:imgurl]        = params[:room][:imgurl]
      @room[:max_occupancy] = params[:room][:max_occupancy]
      if @room.save
        redirect_to :back, notice: "#{@room.name} has been created"
      else
        redirect_to :back, alert: "Error occured, room not saved"
      end
    else
     redirect_to :back, alert: "Access Denied"
    end
 end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
      if user_is_admin?

      user = current_employee
      @company = user.company
      @room    = @company.rooms.build

      @room[:name]          = params[:room][:name]
      @room[:location]      = params[:room][:location]
      @room[:room_number]   = params[:room][:room_number]
      @room[:imgurl]        = params[:room][:imgurl]
      @room[:max_occupancy] = params[:room][:max_occupancy]
      if @room.save
        redirect_to :back, notice: "#{@room.name} has been updated"
      else
        redirect_to :back, alert: "Error occured, updates not saved"
      end
    else
     redirect_to :back, alert: "Access Denied"
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    if user_is_admin?
      user = current_employee
      company = user.company
      @room = @company.rooms

      @room.destroy
      respond_to do |format|
        format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    def update_rooms
      Room.all.each do |room|
        next_meeting_start_time = room.meetings.where("start_time > '#{Time.now}'").minimum(:start_time) || Time.new(2038,1,19,3,14,07)
        available = room.meetings.where("start_time < '#{Time.now}' AND end_time > '#{Time.now}'").none?
        room.update(next_meeting_start_time: next_meeting_start_time, available: available);
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :max_occupancy, :room_number, :imgurl, :location)
    end
end
