class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @company = employee_company
    @current_employee = current_employee
    @rooms_array = get_rooms_array
  end

  def show
  end

  def new
    if user_is_admin?
      @room = Room.new
      @all_rooms = company_rooms.pluck(:name)
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def edit
  end

  def search
    @current_employee = current_employee
    @rooms_array = get_rooms_array(company_rooms.search_for(params[:search].downcase))
  end

  def search_advance
    @current_employee = current_employee
    @rooms_array = get_rooms_array(company_rooms.search_with(params))
    respond_to do |format|
      format.html { render :search }
      format.json { render json: @rooms_array }
    end
  end

  def create
    if user_is_admin?
      user               = current_employee
      @company           = user.company
      @room              = Room.new(room_params)
      @room[:company_id] = @company.id

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
      @room = Room.updated_room(@room, params)

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

    def company_rooms
      Room.where(company_id: current_employee.company_id)
    end

    def get_rooms_array(rooms = company_rooms)
      rooms.map { |room| [room, room.amenities.pluck(:perk).sort.join(" , "), room.get_next_meeting_details] }
    end

    def room_params
      params.require(:room).permit(:name, :max_occupancy, :room_number, :imgurl, :location)
    end
end
