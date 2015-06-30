class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    Room.all.each { |room| room.update_time_sensitive_values }
    @rooms = Room.search_with(params).sort_with(params).paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html
      format.json { render json: @rooms }
    end
  end

  def show
    room = Room.find(params[:id])
  end

  def new
    if user_is_admin?
      @room = Room.new
      @all_rooms = Room.where(company_id: current_employee.company_id).pluck(:name)
    else
      redirect_to :back, alert: "Access Denied"
    end
  end

  def edit
  end

  def search
    if params[:search].to_i > 0
      @room_occupancy = Room.where("max_occupancy >" + params[:search])
                            .paginate(:page => params[:page], :per_page => 10)
      @room_name = []
      @room_location = []
    else
      @room_name      = Room.where("lower(name) LIKE ?", "%" + params[:search] + "%")
                            .paginate(:page => params[:page], :per_page => 10)

      @room_location  = Room.where("lower(location) LIKE ?", "%" + params[:search] + "%")
                            .paginate(:page => params[:page], :per_page => 10)
      @room_occupancy = []
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
    current_employee.company
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name, :max_occupancy, :room_number, :imgurl, :location)
    end
end
