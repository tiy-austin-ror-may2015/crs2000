class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
 def create
  # if user_is_admin? # replace with actual method

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
    # else
    # redirect_to :back, alert: "Access Denied"
    # end
 end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :max_occupancy, :room_number, :imgurl, :location)
    end
end
