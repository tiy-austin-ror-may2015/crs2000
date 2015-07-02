class RoomsPdf < Prawn::Document
  def initialize(room, admin, company)
    super()
    @room = room
    @admin = admin
    @company = company
    greeting
    rooms
    rooms_rows
  end

  def greeting
    move_down 2
    text "#{@admin.name.capitalize},"
    move_down 10
    text "This is the room inventory information for #{@company.name}."
  end

  def rooms
    move_down 10
    table rooms_rows, position: :center do
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
