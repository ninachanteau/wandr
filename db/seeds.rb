require 'faker'

puts "Destroying database..."

Activity.destroy_all
Accommodation.destroy_all
Restaurant.destroy_all
Transportation.destroy_all
Participation.destroy_all
User.destroy_all
Trip.destroy_all

puts "Creating 4 trips"

barcelona = Trip.create!(
 destination: "Barcelona",
 description: "Trip to Barcelona for Elsa's 30th",
 name: "Barcelona - Elsa's Birthday",
 remote_photo_url: "http://tempemp.co/wp-content/uploads/2017/11/barcelona-cultura-historia.jpg")

stockholm = Trip.create!(
 destination: "Stockholm",
 description: "Let's meet in Stockholm for Nina's bachelorette",
 name: "Nina's Bachelorette",
 remote_photo_url: "https://handluggageonly.co.uk/wp-content/uploads/2017/12/Gamla-Stan-3.jpg")

cuba = Trip.create!(
 destination: "Cuba",
 description: "Let's enjoy some sun and some mojitos",
 name: "End of semester trip",
 start_date: "Sat, 24 Mar 2018",
 end_date: "Sat, 31 Mar 2018",
 remote_photo_url: "https://images.unsplash.com/photo-1500759285222-a95626b934cb?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=15641eda0c2356f833f0c21dcfa3ddc8&auto=format&fit=crop&w=1650&q=80")

norway = Trip.create!(
 destination: "Norway",
 description: "Let's discover the fjords landscapes",
 name: "Summer break",
 start_date: "Tue, 01 Aug 2017",
 end_date: "Sat, 12 Aug 2017",
 remote_photo_url: "https://images.unsplash.com/photo-1506967554512-fc1ad1c0b21b?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=df98a3f56f0729948a6cb360d9d916b1&auto=format&fit=crop&w=1655&q=80")

puts "Trips created"
puts "------"
puts "Creating 2 users"

nina = User.create!(
 email: "nina.chanteau@hec.edu",
 first_name: "Nina",
 last_name: "Chanteau",
 password: "123456",
 remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/ninachanteau")

kenza = User.create!(
email: "kenza.aboudrar@gmail.com",
first_name: "Kenza",
last_name: "Aboudrar",
password: "123456",
remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/kenzaaboudrar")

puts "Users created"
puts "------"
puts "Creating 6 participations"

kenza_cuba = Participation.new
kenza_cuba.user = kenza
kenza_cuba.trip = cuba
kenza_cuba.email = kenza.email
kenza_cuba.pseudo = kenza.first_name
kenza_cuba.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/kenzaaboudrar"
kenza_cuba.save!

nina_barcelona = Participation.new
nina_barcelona.user = nina
nina_barcelona.trip = barcelona
nina_barcelona.email = nina.email
nina_barcelona.pseudo = nina.first_name
nina_barcelona.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_barcelona.save!

nina_stockholm = Participation.new
nina_stockholm.user = nina
nina_stockholm.trip = stockholm
nina_stockholm.email = nina.email
nina_stockholm.pseudo = nina.first_name
nina_stockholm.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_stockholm.save!

nina_cuba = Participation.new
nina_cuba.user = nina
nina_cuba.trip = cuba
nina_cuba.email = nina.email
nina_cuba.pseudo = nina.first_name
nina_cuba.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_cuba.save!

nina_norway = Participation.new
nina_norway.user = nina
nina_norway.trip = norway
nina_norway.email = nina.email
nina_norway.pseudo = nina.first_name
nina_norway.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_norway.save!

alex_norway = Participation.new
alex_norway.trip = norway
alex_norway.email = "alexandre.smadja@hec.edu"
alex_norway.pseudo = "Alex"
alex_norway.save!

alex_cuba = Participation.new
alex_cuba.trip = cuba
alex_cuba.email = "alexandre.smadja@hec.edu"
alex_cuba.pseudo = "Alex"
alex_cuba.save!

puts "Participations created"
puts "------"
puts "Creating 2 transportations"

flight_cuba_kenza = Transportation.new(
  departure_port: "Paris",
  arrival_port: "José Martí International Airport",
  departure_date: "Sat, 24 Mar 2018 17:00:00 UTC +00:00,",
  arrival_date: "Sun, 25 Mar 2018 10:00:00 UTC +00:00,",
  status: "Wishlist",
  price_per_person: 99.00
  )
flight_cuba_kenza.participation = kenza_cuba
flight_cuba_kenza.save!

flight_cuba_nina = Transportation.new(
  departure_port: "Paris",
  arrival_port: "José Martí International Airport",
  departure_date: "Sat, 24 Mar 2018 17:00:00 UTC +00:00,",
  arrival_date: "Sun, 25 Mar 2018 10:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 123.00
  )
flight_cuba_nina.participation = nina_cuba
flight_cuba_nina.save!

puts "Transportations created"
puts "------"
puts "Creating 1 accommodation"

hotel_cuba_nina = Accommodation.create(
  name: "IBEROSTAR Parque Central",
  address: "267 Agramonte, La Habana, Cuba",
  start_date: "Sun, 25 Mar 2018",
  end_date: "Mon, 26 Mar 2018",
  status: "Booked",
  reference_number: "GRYJSL",
  number_of_nights: 1,
  phone_number: "0273527353",
  url: "https://www.iberostar.com/en/hotels/la-habana/iberostar-parque-central",
  email: "iberostar@lahavane.com",
  total_price: 150.00,
  number_of_rooms: 2
  )
hotel_cuba_nina.trip = cuba
hotel_cuba_nina.participation = nina_cuba
hotel_cuba_nina.save!

puts "Accommodation created"
puts "------"
puts "Creating 1 restaurant"

restaurant_cuba_nina = Restaurant.create(
  name: "Bodeguita del medio",
  address: "Empedrado, La Habana, Cuba",
  date: "Sun, 25 Mar 2018 20:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "0753644527",
  description: "best bar in Cuba",
  url: "http://labodeguitarestaurant.restaurantwebx.com/",
  email: "bodeguita@lahavane.com"
  )
restaurant_cuba_nina.trip = cuba
restaurant_cuba_nina.participation = nina_cuba
restaurant_cuba_nina.save!

puts "Restaurant created"
puts "------"
puts "Creating 1 activity"

activity_cuba_nina = Activity.create(
  name: "Museum of the Revolution",
  address: "Avenida Bélgica, La Habana, Cuba",
  date: "Mon, 26 Mar 2018 11:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "0753644527",
  description: "amazing museum",
  url: "https://www.tripadvisor.fr/Attraction_Review-g147271-d147980-Reviews-Museum_of_the_Revolution_Museo_de_la_Revolucion-Havana_Ciudad_de_la_Habana_Provinc.html",
  email: "museum@lahavane.com"
  )
activity_cuba_nina.trip = cuba
activity_cuba_nina.participation = nina_cuba
activity_cuba_nina.save!

puts "Activity created"
puts "------"
puts "Finished!"
