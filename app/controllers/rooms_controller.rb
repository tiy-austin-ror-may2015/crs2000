class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    update_rooms
    name = params.fetch("name", "")
    max_occupancy = params.fetch("max_occupancy", "0")
    room_number = params.fetch("room_number", "%%")
    meetings_count = params.fetch("meetings_count", "%%")
    available = params.fetch("available", "%%")
    location = params.fetch("location", "%%")
    @rooms = Room.where("lower(name) LIKE lower('%#{name}%') AND
                          max_occupancy >= #{max_occupancy} AND
                          CAST(room_number AS TEXT) LIKE '#{room_number}' AND
                          CAST(meetings_count AS TEXT) LIKE '#{meetings_count}' AND
                          CAST(available AS TEXT) LIKE '#{available}' AND
                          lower(location) LIKE lower('%#{location}%')")

    sort_by = params.fetch("sort_by", "created_at||").split("||")
    sort_dir = params.fetch("sort_dir", "ASC||").split("||")
    sort_hash = Hash[sort_by.zip(sort_dir)]
    order_query = []
    sort_hash.each { |sort_by, sort_dir| order_query << "#{sort_by} #{sort_dir}" }
    order_query = order_query.join(", ")

    @rooms = @rooms.order(order_query).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.json { render json: @rooms }
    end
  end

  def show
    room = Room.find(params[:id])
  end

  def new
    @room = Room.new
    @all_rooms = Room.where(company_id: current_employee.company_id).pluck(:name)
  end

  def edit
  end

 def create
  if user_is_admin?

      @company = employee_company
      @room    = @company.rooms.build

      @room[:name]          = params[:room][:name]
      @room[:location]      = params[:room][:location]
      @room[:room_number]   = params[:room][:room_number]
      @room[:imgurl]        = params[:room][:imgurl]
      @room[:max_occupancy] = params[:room][:max_occupancy]
      if @room.save
        redirect_to @room, notice: "#{@room.name} has been created"
      else
        redirect_to :back, alert: "Error occured, room not saved"
      end
    else
     redirect_to :back, alert: "Access Denied"
    end
 end

  def update
      if user_is_admin?

      @company = employee_company
      @room    = @company.rooms.build

      @room[:name]          = params[:room][:name]
      @room[:location]      = params[:room][:location]
      @room[:room_number]   = params[:room][:room_number]
      @room[:imgurl]        = params[:room][:imgurl]
      @room[:max_occupancy] = params[:room][:max_occupancy]
      if @room.save
        redirect_to @room, notice: "#{@room.name} has been updated"
      else
        redirect_to :back, alert: "Error occured, updates not saved"
      end
    else
     redirect_to :back, alert: "Access Denied"
    end
  end

  def destroy
    if user_is_admin?
      @company = employee_company
      @room = Room.find(params[:id])
      @room.destroy
      redirect_to rooms_url, notice: 'Room was successfully destroyed.'
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def employee_company
    current_employee.company
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def update_rooms
      Room.all.each do |room|
        hours_until_next_meeting = room.meetings.where("start_time > '#{Time.now}'").minimum(:start_time) || Time.new(2038,1,19,3,14,07)
        hours_until_next_meeting = ((hours_until_next_meeting - Time.now) / 3600).round
        available = room.meetings.where("start_time < '#{Time.now}' AND end_time > '#{Time.now}'").none?
        room.update(hours_until_next_meeting: hours_until_next_meeting, available: available)
      end
    end

    def room_params
      params.require(:room).permit(:name, :max_occupancy, :room_number, :imgurl, :location)
    end
end
