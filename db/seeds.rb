# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Group.destroy_all
Game.destroy_all


Group.create(name: "Board Games")
Group.create(name: "Card Games")
Group.create(name: "Video Games - PS4")

Game.create(name: "Destiny", group_id: 3)
Game.create(name: "Betrayal at House on the Hill", group_id: 1)
Game.create(name: "Takenoko", group_id: 1)
Game.create(name: "Fluxx", group_id: 2)
