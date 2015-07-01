class RoomsPdf < Prawn::Document
  def initialize(room)
    super()
    @room = room
     rooms
     rooms_rows
  end

  def rooms
    move_down 10
    table rooms_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD","FFFFFF"]
      self.headers = true
    end
  end

  def rooms_rows
    [["Name", "Number", "Location", "Max Occupancy"]]
    @rooms.map do |item|
      [item.name, item.number, item.location, item.max_occupation]
    end
  end
end
