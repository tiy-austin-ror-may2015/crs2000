class AdminController < ApplicationController

  def index
    @meetings = Meeting.all
    @rooms = Room.all
  end

end
