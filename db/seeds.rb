# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Destroying database..."


User.destroy_all
Transportation.destroy_all
Participation.destroy_all
Trip.destroy_all

puts "Creating 2 trips.."
barcelona = Trip.create(
  destination: "Barcelona",
  description: "Trip to Barcelona for Elsa's 30th",
  name: "Barcelona - Elsa's Birthday",
  remote_photo_url: "http://tempemp.co/wp-content/uploads/2017/11/barcelona-cultura-historia.jpg"
)

stockholm = Trip.create(
  destination: "Stockholm",
  description: "Let's meet in Stockholm for Nina's bachelorette",
  name: "Nina's Bachelorette",
  remote_photo_url: "https://handluggageonly.co.uk/wp-content/uploads/2017/12/Gamla-Stan-3.jpg"
)

puts "Trips created"

"------"

puts "Creating 2 users"

nina = User.create(
  email: "nina.chanteau@hec.edu",
  first_name: "Nina",
  last_name: "Chanteau",
  password: "123456")

kenza = User.create(
email: "kenza.aboudrar@gmail.com",
first_name: "Kenza",
last_name: "Aboudrar",
password: "123456")

puts "Users created"

"------"

puts "Creating 3 participations"

kenza_barcelona = Participation.create
kenza_barcelona.user = kenza
kenza_barcelona.trip = barcelona
kenza_barcelona.save

nina_barcelona = Participation.create
nina_barcelona.user = nina
nina_barcelona.trip = barcelona
nina_barcelona.save

nina_stockholm = Participation.create
nina_stockholm.user = nina
nina_stockholm.trip = stockholm
nina_stockholm.save

puts "Participations created"

"------------"

puts "Creating 3 transportations"

train_barcelona_kenza = Transportation.create(
  departure_port: "Gare Montparnasse",
  arrival_port: "Barcelona"
  )
train_barcelona_kenza.participation = kenza_barcelona
train_barcelona_kenza.save

train_barcelona_nina = Transportation.create(
  departure_port: "Gare Montparnasse",
  arrival_port: "Barcelona"
  )
train_barcelona_nina.participation = nina_barcelona
train_barcelona_nina.save

flight_stockholm_nina = Transportation.create(
  departure_port: "ORY",
  arrival_port: "STK"
  )
flight_stockholm_nina.participation = nina_stockholm
flight_stockholm_nina.save


puts "Transportations created"

"----------"


puts "Finished!"
