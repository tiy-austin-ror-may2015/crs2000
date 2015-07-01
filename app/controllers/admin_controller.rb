class AdminController < ApplicationController

  def reports_meetings
    @reports_meetings = Meeting.all
  end

  def reports_rooms
    @reports_rooms = Room.all
    @top_rooms = Meeting.joins(:room).group(:room).order('count_all DESC').limit(3).count
  end

  def busiest_employees
    @busiest_employees = Meeting.sort_by

  end


end
