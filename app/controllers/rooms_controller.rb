def show
  room = Room.find(params[:id])
  @name = room.title
  @agenda = room.agenda
  @

end
