class RoomsPdf < Prawn::Document
  def initialize(room)
    super()
    @room = room
    rooms
    rooms_rows
  end

  def rooms
    move_down 10
    table rooms_rows, position: :center, header: true do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ["DDDDDD","FFFFFF"]
    end
  end

  def rooms_rows
    [["Room Name", "Location", "Max Occupancy", "Available"]] + @room.map do |item|
      [item.name, item.location, item.max_occupancy, item.available.inspect]
    end
  end
end
