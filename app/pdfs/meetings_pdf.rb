class MeetingsPdf < Prawn::Document
  def initialize(meeting, admin, company)
    super()
    @meeting = meeting
    @admin = admin
    @company = company
    greeting
    # footers
    meetings
    meetings_rows
  end

  def greeting
    move_down 2
    text "#{@admin.name.capitalize},"
    move_down 10
    text "This is the room inventory information for #{@company.name}."
  end

  # def footers

  #   end
  # end

  def meetings
    move_down 10
    table meetings_rows, position: :center do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.header = true
      self.row_colors = ["DDDDDD","FFFFFF"]
    end
  end

  def meetings_rows
      [["Title", "Agenda", "Start Time", "End Time"]] +
    @meeting.map do |item|
      [item.title, item.agenda,  item.start_time.strftime("%m-%e-%y %H:%M"), item.end_time.strftime("%m-%e-%y %H:%M")]
    end
  end
end

