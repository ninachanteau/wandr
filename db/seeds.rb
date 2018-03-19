# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Destroying database..."
# Trip.destroy_all
# Participation.destroy_all
# User.destroy_all


# Transportation.destroy_all



puts "Creating 2 trips.."
barcelona = Trip.create(
  destination: "Barcelona",
  description: "Trip to Barcelona for Elsa's 30th"
  name: "Barcelona - Elsa's Birthday"
)

stockholm = Trip.create(
  destination: "Stockholm",
  description: "Let's meet in Stockholm for Nina's bachelorette"
  name: "Nina's Bachelorette"
)

puts "Trips created"


puts "Finished!"
