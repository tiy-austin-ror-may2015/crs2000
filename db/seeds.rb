# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


company = Company.create(name: "Initech")

30 times do

room_name = ["Blue Bonnet Room", "Waterfall Room", "Media Room", "Teleconference room", "Willie Nelson Room", "Lone Star Room", "Holodeck", "Dave's Office"]
location = ['Skunkworks Lab', 'Development Wing: East', 'Development Wing: West', 'Elusk Musk Building', 'Turing Center']
rooms = Room.create(name: room_name.sample, max_occupancy: rand(5..30), room_number: rand(100..400), location: location.sample,
  company_id: company.id)

end
