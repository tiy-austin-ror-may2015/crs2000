class MeetingsPdf < Prawn::Document
  def initialize(room)
    super()
    @meeting = meeting
    meetings
    meetings_rows
  end


  def meetings
    move_down 10
    table meetings_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.header = true
      self.row_colors = ["DDDDDD","FFFFFF"]
    end
  end

  def meetings_rows
      [["Title", "Agenda", "Room ID" "Start Time", "End Time", "Private"]] +
    @meeting.map do |item|
      [item.title, item.agenda, item.room_id, item.private.inspect ]
    end
  end
end

