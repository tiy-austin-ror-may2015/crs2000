class RoomsPdf < Prawn::Document
  def initialize(room)
    super()
    @room = room
    line_items
  end

  def room_name line items
    text "Order \#{@oroom.room_name}"
  end

  def room_number
    text ""
  end

  def room_occupancy
    text
  end

  def room_location
    text
  end

end
