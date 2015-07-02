class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @company = employee_company
    @rooms_array = get_rooms_array
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    if user_is_admin?
      @room = Room.new
      @all_rooms = Room.where(company_id: current_company_id).pluck(:name)
    else
      redirect_to root_path, alert: "Access Denied"
    end
  end

  def edit
  end

  def search
    @rooms_array = get_rooms_array(company_rooms.search_for(params))
    respond_to do |format|
      format.html
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
         redirect_to root_path, alert: "Error occured, room not saved"
       end
     else
      redirect_to root_path, alert: "Access Denied"
    end
 end

  def update
      if user_is_admin?

      @room = Room.find(params[:id])

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

      @room = Room.find(params[:id])
      @room.destroy
      redirect_to rooms_url, notice: 'Room was successfully destroyed.'
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def employee_company
    current_company
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
