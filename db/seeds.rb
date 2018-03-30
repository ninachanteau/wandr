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

costarica = Trip.create!(
 destination: "Costa Rica",
 description: "Winter escape",
 name: "Surf trip",
 remote_photo_url: "https://images.unsplash.com/photo-1519177565-a7201150fec3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0514ab92a3e5738b157e5e417339d6d&auto=format&fit=crop&w=1568&q=80")

namibia = Trip.create!(
 destination: "Namibia",
 description: "Honey moon plans",
 name: "Dream Safari",
 remote_photo_url: "https://images.unsplash.com/photo-1519351446433-171915376b1a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1aa41dff23555482ebfea57f76ead7e8&auto=format&fit=crop&w=1650&q=80")

nyc = Trip.create!(
 destination: "NYC",
 description: "Let's discover NYC for Spring!",
 name: "End of semester trip",
 start_date: "Thu, 03 May 2018",
 end_date: "Wed, 09 May 2018",
 remote_photo_url: "https://images.unsplash.com/photo-1448317846460-907988886b33?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=c29e88927cbae491482117b4dcee1e36&auto=format&fit=crop&w=1650&q=80")

lisbon = Trip.create!(
 destination: "Lisbon",
 description: "Let's enjoy the Portuguese sun!",
 name: "Week-end get away",
 start_date: "Fri, 09 Mar 2018",
 end_date: "Mon, 12 Mar 2018",
 remote_photo_url: "https://images.unsplash.com/photo-1488742286505-cce1f9344f51?ixlib=rb-0.3.5&s=a271b26112d9ae2096086b0261c430b2&auto=format&fit=crop&w=668&q=80")

puts "Trips created"
puts "------"
puts "Creating 7 users"

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

julie = User.create!(
email: "julie.giuliani@hec.edu",
first_name: "Julie",
last_name: "Giuliani",
password: "123456",
remote_avatar_url: "https://scontent-bru2-1.xx.fbcdn.net/v/t31.0-8/29352174_10215116937744490_3178796321440473683_o.jpg?_nc_cat=0&_nc_eui2=v1%3AAeEbHeA7HXTgpahB8zETM7r05FJBEV0RxYlDJmOpFFQTdoZOcQ4dKbtwMOAYIZr7OIneq8zTbyarKEeNHIOAeyCS7LWDlTmLhn8C3Xy9LvN8rw&oh=0e524dc939c75105a45034347cd84722&oe=5B30E775")

julia = User.create!(
email: "julia.jibert@ehl.ch",
first_name: "Julia",
last_name: "jibert",
password: "123456",
remote_avatar_url: "https://scontent-bru2-1.xx.fbcdn.net/v/t1.0-9/20915151_1914427425464496_1029012009906877112_n.jpg?_nc_cat=0&oh=d1804dcaecf38fb1d6f8f196f607ec3d&oe=5B3ECF26")

alex = User.create!(
email: "alexandre.smadja@hec.edu",
first_name: "Alex",
last_name: "Smadja",
password: "123456",
remote_avatar_url: "https://scontent-bru2-1.xx.fbcdn.net/v/t1.0-9/29543098_10215116936744465_3595477249990075681_n.jpg?_nc_cat=0&_nc_eui2=v1%3AAeEC2-E-EPYNojIXayOXoirl5JSKnlQ4RsME5K_714Nlfx1-ElObyILJHPoCBu5o0umauwQaamIv9KIiJpA7ejD5Hm1bJz5Yzql8-mzWNbMlKA&oh=c4c082e1ea326b7859bb3beadf4ec777&oe=5B312742")

elsa = User.create!(
email: "elsa.gounot@gmail.com",
first_name: "Elsa",
last_name: "Gounot",
password: "123456",
remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/elsagt")

marion = User.create!(
email: "bergeret.marion@gmail.com",
first_name: "Marion",
last_name: "Bergeret",
password: "123456",
remote_avatar_url: "https://kitt.lewagon.com/placeholder/users/marion-bergeret")

puts "Users created"
puts "------"
puts "Creating 9 participations"

nina_lisbon = Participation.new
nina_lisbon.user = nina
nina_lisbon.trip = lisbon
nina_lisbon.email = nina.email
nina_lisbon.pseudo = nina.first_name
nina_lisbon.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_lisbon.save!

marion_lisbon = Participation.new
marion_lisbon.user = marion
marion_lisbon.trip = lisbon
marion_lisbon.email = marion.email
marion_lisbon.pseudo = marion.first_name
marion_lisbon.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/marion-bergeret"
marion_lisbon.save!

nina_nyc = Participation.new
nina_nyc.user = nina
nina_nyc.trip = nyc
nina_nyc.email = nina.email
nina_nyc.pseudo = nina.first_name
nina_nyc.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_nyc.save!

kenza_nyc = Participation.new
kenza_nyc.user = kenza
kenza_nyc.trip = nyc
kenza_nyc.email = kenza.email
kenza_nyc.pseudo = kenza.first_name
kenza_nyc.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/kenzaaboudrar"
kenza_nyc.save!

elsa_nyc = Participation.new
elsa_nyc.user = elsa
elsa_nyc.trip = nyc
elsa_nyc.email = elsa.email
elsa_nyc.pseudo = elsa.first_name
elsa_nyc.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/elsagt"
elsa_nyc.save!

nina_costarica = Participation.new
nina_costarica.user = nina
nina_costarica.trip = costarica
nina_costarica.email = nina.email
nina_costarica.pseudo = nina.first_name
nina_costarica.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_costarica.save!

kenza_costarica = Participation.new
kenza_costarica.user = kenza
kenza_costarica.trip = costarica
kenza_costarica.email = kenza.email
kenza_costarica.pseudo = kenza.first_name
kenza_costarica.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/kenzaaboudrar"
kenza_costarica.save!

nina_namibia = Participation.new
nina_namibia.user = nina
nina_namibia.trip = namibia
nina_namibia.email = nina.email
nina_namibia.pseudo = nina.first_name
nina_namibia.remote_avatar_url = "https://kitt.lewagon.com/placeholder/users/ninachanteau"
nina_namibia.save!

alex_namibia = Participation.new
alex_namibia.user = alex
alex_namibia.trip = namibia
alex_namibia.email = alex.email
alex_namibia.pseudo = alex.first_name
alex_namibia.remote_avatar_url = "https://scontent-bru2-1.xx.fbcdn.net/v/t1.0-9/29543098_10215116936744465_3595477249990075681_n.jpg?_nc_cat=0&_nc_eui2=v1%3AAeEC2-E-EPYNojIXayOXoirl5JSKnlQ4RsME5K_714Nlfx1-ElObyILJHPoCBu5o0umauwQaamIv9KIiJpA7ejD5Hm1bJz5Yzql8-mzWNbMlKA&oh=c4c082e1ea326b7859bb3beadf4ec777&oe=5B312742"
alex_namibia.save!

puts "Participations created"
puts "------"
puts "Creating 12 transportations"

go_nyc_kenza = Transportation.new(
  departure_port: "Aéroport CDG Terminal 1",
  arrival_port: "JFK Terminal 1",
  departure_date: "Thu, 03 May 2018 10:00:00 UTC +00:00,",
  arrival_date: "Fri, 09 Mar 2018 14:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 320.00,
  reference_number: "NKUSTG"
  )
go_nyc_kenza.participation = kenza_nyc
go_nyc_kenza.save!

back_nyc_kenza = Transportation.new(
  departure_port: "Newark airport (EWR)",
  arrival_port: "Aéroport CDG Terminal 1",
  departure_date: "Tue, 08 May 2018 22:00:00 UTC +00:00,",
  arrival_date: "Wed, 09 May 2018 09:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 210.00,
  reference_number: "NKUSTG"
  )
back_nyc_kenza.participation = kenza_nyc
back_nyc_kenza.save!

go_nyc_elsa = Transportation.new(
  departure_port: "Aéroport CDG Terminal 1",
  arrival_port: "JFK Terminal 1",
  departure_date: "Thu, 03 May 2018 10:00:00 UTC +00:00,",
  arrival_date: "Fri, 09 Mar 2018 14:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 320.00,
  reference_number: "NKUSTG"
  )
go_nyc_elsa.participation = elsa_nyc
go_nyc_elsa.save!

back_nyc_elsa = Transportation.new(
  departure_port: "Newark airport (EWR)",
  arrival_port: "Aéroport CDG Terminal 1",
  departure_date: "Tue, 08 May 2018 22:00:00 UTC +00:00,",
  arrival_date: "Wed, 09 May 2018 09:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 210.00,
  reference_number: "NKUSTG"
  )
back_nyc_elsa.participation = elsa_nyc
back_nyc_elsa.save!

go_nyc_nina = Transportation.new(
  departure_port: "Aéroport CDG Terminal 1",
  arrival_port: "JFK Terminal 1",
  departure_date: "Thu, 03 May 2018 10:00:00 UTC +00:00,",
  arrival_date: "Fri, 09 Mar 2018 14:00:00 UTC +00:00,",
  status: "Wishlist",
  price_per_person: 320.00,
  reference_number: "VTDKSO"
  )
go_nyc_nina.participation = nina_nyc
go_nyc_nina.save!

back_nyc_nina = Transportation.new(
  departure_port: "JFK Terminal 1",
  arrival_port: "Aéroport CDG Terminal 1",
  departure_date: "Tue, 08 May 2018 16:00:00 UTC +00:00,",
  arrival_date: "Wed, 09 May 2018 04:00:00 UTC +00:00,",
  status: "Wishlist",
  price_per_person: 190.00,
  reference_number: "SBYUZS"
  )
back_nyc_nina.participation = nina_nyc
back_nyc_nina.save!

go_nyc_nina = Transportation.new(
  departure_port: "Aéroport CDG Terminal 1",
  arrival_port: "Newark airport (EWR)",
  departure_date: "Thu, 03 May 2018 17:00:00 UTC +00:00,",
  arrival_date: "Fri, 09 Mar 2018 23:00:00 UTC +00:00,",
  status: "Wishlist",
  price_per_person: 330.00,
  reference_number: "BDYUST"
  )
go_nyc_nina.participation = nina_nyc
go_nyc_nina.save!

back_nyc_nina = Transportation.new(
  departure_port: "Newark airport (EWR)",
  arrival_port: "Aéroport CDG Terminal 1",
  departure_date: "Tue, 08 May 2018 22:00:00 UTC +00:00,",
  arrival_date: "Wed, 09 May 2018 09:00:00 UTC +00:00,",
  status: "Wishlist",
  price_per_person: 210.00,
  reference_number: "BDBYET"
  )
back_nyc_nina.participation = nina_nyc
back_nyc_nina.save!

back_lisbon_nina = Transportation.new(
  departure_port: "Lisboa, Aeroporto da Portela Lisboa (LIS)",
  arrival_port: "Aéroport CDG Terminal 1",
  departure_date: "Mon, 12 Mar 2018 10:00:00 UTC +00:00,",
  arrival_date: "Mon, 12 Mar 2018 12:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 43.00,
  reference_number: "HYTGLI"
  )
back_lisbon_nina.participation = nina_lisbon
back_lisbon_nina.save!

go_lisbon_nina = Transportation.new(
  departure_port: "Aéroport CDG Terminal 1",
  arrival_port: "Lisboa, Aeroporto da Portela Lisboa (LIS)",
  departure_date: "Fri, 09 Mar 2018 14:00:00 UTC +00:00,",
  arrival_date: "Fri, 09 Mar 2018 16:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 75.00,
  reference_number: "HYTGLI"
  )
go_lisbon_nina.participation = nina_lisbon
go_lisbon_nina.save!

go_lisbon_marion = Transportation.new(
  departure_port: "Aéroport CDG Terminal 1",
  arrival_port: "Lisboa, Aeroporto da Portela Lisboa (LIS)",
  departure_date: "Fri, 09 Mar 2018 14:00:00 UTC +00:00,",
  arrival_date: "Fri, 09 Mar 2018 16:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 75.00,
  reference_number: "DRTNKZ"
  )
go_lisbon_marion.participation = marion_lisbon
go_lisbon_marion.save!

back_lisbon_marion = Transportation.new(
  departure_port: "Lisboa, Aeroporto da Portela Lisboa (LIS)",
  arrival_port: "Aéroport CDG Terminal 1",
  departure_date: "Mon, 12 Mar 2018 10:00:00 UTC +00:00,",
  arrival_date: "Mon, 12 Mar 2018 12:00:00 UTC +00:00,",
  status: "Booked",
  price_per_person: 43.00,
  reference_number: "DRTNKZ"
  )
back_lisbon_marion.participation = marion_lisbon
back_lisbon_marion.save!

puts "Transportations created"
puts "------"
puts "Creating 13 accommodations"

hotel_nyc_elsa = Accommodation.create(
  name: "The Mark Hotel",
  address: "25 E 77th St, New York, NY 10075, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "CDT03Y",
  number_of_nights: 5,
  phone_number: "+1 212-744-4300",
  url: "https://www.themarkhotel.com/",
  email: "lemarkhotel@newyork.com",
  total_price: 1387,
  number_of_rooms: 2,
  description: "Very fancy",
  remote_photo_url: "https://s-ec.bstatic.com/images/hotel/max1280x900/434/43496058.jpg"
  )
hotel_nyc_elsa.trip = nyc
hotel_nyc_elsa.participation = elsa_nyc
hotel_nyc_elsa.save!

hotel_nyc_elsa = Accommodation.create(
  name: "The Ludlow Hotel",
  address: "180 Ludlow St, New York, NY 10002, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "JDY654",
  number_of_nights: 5,
  phone_number: "+1 212-432-1818",
  url: "http://www.ludlowhotel.com/",
  email: "ludlow@newyork.com",
  total_price: 899,
  number_of_rooms: 2,
  description: "Perfect location in Lower East Side!",
  remote_photo_url: "https://s-ec.bstatic.com/images/hotel/max1280x900/328/32845437.jpg"
  )
hotel_nyc_elsa.trip = nyc
hotel_nyc_elsa.participation = elsa_nyc
hotel_nyc_elsa.save!

hotel_nyc_elsa = Accommodation.create(
  name: "The Union Hotel",
  address: "611 Degraw St, Brooklyn, NY 11217, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "UY7609",
  number_of_nights: 5,
  phone_number: "+1 718-403-0614",
  url: "https://www.choicehotels.com/new-york/brooklyn/ascend-hotels/ny473?source=gyxt",
  email: "theunionhotel@newyork.com",
  total_price: 448,
  number_of_rooms: 1,
  description: "Nice and cheap hostel but far from city center",
  remote_photo_url: "https://exp.cdn-hotels.com/hotels/5000000/4460000/4453800/4453783/6521fa8e_z.jpg"
  )
hotel_nyc_elsa.trip = nyc
hotel_nyc_elsa.participation = elsa_nyc
hotel_nyc_elsa.save!

hotel_nyc_kenza = Accommodation.create(
  name: "The Mark Hotel",
  address: "25 E 77th St, New York, NY 10075, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "CDT03Y",
  number_of_nights: 5,
  phone_number: "+1 212-744-4300",
  url: "https://www.themarkhotel.com/",
  email: "lemarkhotel@newyork.com",
  total_price: 1387,
  number_of_rooms: 2,
  description: "Very fancy",
  remote_photo_url: "https://s-ec.bstatic.com/images/hotel/max1280x900/434/43496058.jpg"
  )
hotel_nyc_kenza.trip = nyc
hotel_nyc_kenza.participation = kenza_nyc
hotel_nyc_kenza.save!

hotel_nyc_kenza = Accommodation.create(
  name: "The Ludlow Hotel",
  address: "180 Ludlow St, New York, NY 10002, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "JDY654",
  number_of_nights: 5,
  phone_number: "+1 212-432-1818",
  url: "http://www.ludlowhotel.com/",
  email: "ludlow@newyork.com",
  total_price: 899,
  number_of_rooms: 2,
  description: "Perfect location in Lower East Side!",
  remote_photo_url: "https://s-ec.bstatic.com/images/hotel/max1280x900/328/32845437.jpg"
  )
hotel_nyc_kenza.trip = nyc
hotel_nyc_kenza.participation = kenza_nyc
hotel_nyc_kenza.save!

hotel_nyc_kenza = Accommodation.create(
  name: "The Union Hotel",
  address: "611 Degraw St, Brooklyn, NY 11217, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "UY7609",
  number_of_nights: 5,
  phone_number: "+1 718-403-0614",
  url: "https://www.choicehotels.com/new-york/brooklyn/ascend-hotels/ny473?source=gyxt",
  email: "theunionhotel@newyork.com",
  total_price: 448,
  number_of_rooms: 1,
  description: "Nice and cheap hostel but far from city center",
  remote_photo_url: "https://exp.cdn-hotels.com/hotels/5000000/4460000/4453800/4453783/6521fa8e_z.jpg"
  )
hotel_nyc_kenza.trip = nyc
hotel_nyc_kenza.participation = kenza_nyc
hotel_nyc_kenza.save!

hotel_nyc_nina = Accommodation.create(
  name: "The Mark Hotel",
  address: "25 E 77th St, New York, NY 10075, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "CDT03Y",
  number_of_nights: 5,
  phone_number: "+1 212-744-4300",
  url: "https://www.themarkhotel.com/",
  email: "lemarkhotel@newyork.com",
  total_price: 1387,
  number_of_rooms: 2,
  description: "Very fancy",
  remote_photo_url: "https://s-ec.bstatic.com/images/hotel/max1280x900/434/43496058.jpg"
  )
hotel_nyc_nina.trip = nyc
hotel_nyc_nina.participation = nina_nyc
hotel_nyc_nina.save!

hotel_nyc_nina = Accommodation.create(
  name: "The Ludlow Hotel",
  address: "180 Ludlow St, New York, NY 10002, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "JDY654",
  number_of_nights: 5,
  phone_number: "+1 212-432-1818",
  url: "http://www.ludlowhotel.com/",
  email: "ludlow@newyork.com",
  total_price: 899,
  number_of_rooms: 2,
  description: "Perfect location in Lower East Side!",
  remote_photo_url: "https://s-ec.bstatic.com/images/hotel/max1280x900/328/32845437.jpg"
  )
hotel_nyc_nina.trip = nyc
hotel_nyc_nina.participation = nina_nyc
hotel_nyc_nina.save!

hotel_nyc_nina = Accommodation.create(
  name: "The Union Hotel",
  address: "611 Degraw St, Brooklyn, NY 11217, USA",
  start_date: "Thu, 03 May 2018",
  end_date: "Tue, 08 May 2018",
  status: "Wishlist",
  reference_number: "UY7609",
  number_of_nights: 5,
  phone_number: "+1 718-403-0614",
  url: "https://www.choicehotels.com/new-york/brooklyn/ascend-hotels/ny473?source=gyxt",
  email: "theunionhotel@newyork.com",
  total_price: 448,
  number_of_rooms: 1,
  description: "Nice and cheap hostel but far from city center",
  remote_photo_url: "https://exp.cdn-hotels.com/hotels/5000000/4460000/4453800/4453783/6521fa8e_z.jpg"
  )
hotel_nyc_nina.trip = nyc
hotel_nyc_nina.participation = nina_nyc
hotel_nyc_nina.save!

hotel_lisbon_nina = Accommodation.create(
  name: "Memmo Alfama Hotel Lisboa",
  address: "Travessa das Merceeiras, 27 - Alfama, Lisbon, 1100-348, Portugal",
  start_date: "Fri, 09 Mar 2018",
  end_date: "Mon, 12 Mar 2018",
  status: "Booked",
  reference_number: "ZKYDBH",
  number_of_nights: 3,
  phone_number: "0273527353",
  url: "http://memmo-alfama-lisbon.hotel-rn.com",
  email: "memmo-alfama@lisbon.com",
  total_price: 149.00,
  number_of_rooms: 1,
  description: "Amazing view and perfect location in Alfama",
  remote_photo_url: "https://f22bfca7a5abd176cefa-59c40a19620c1f22577ade10e9206cf5.ssl.cf1.rackcdn.com/u/memmo-alfama-architecture-M-01-r.jpg"
  )
hotel_lisbon_nina.trip = lisbon
hotel_lisbon_nina.participation = nina_lisbon
hotel_lisbon_nina.save!

hotel_lisbon_marion = Accommodation.create(
  name: "Memmo Alfama Hotel Lisboa",
  address: "Travessa das Merceeiras, 27 - Alfama, Lisbon, 1100-348, Portugal",
  start_date: "Fri, 09 Mar 2018",
  end_date: "Mon, 12 Mar 2018",
  status: "Booked",
  reference_number: "ZKYDBH",
  number_of_nights: 3,
  phone_number: "0273527353",
  url: "http://memmo-alfama-lisbon.hotel-rn.com",
  email: "memmo-alfama@lisbon.com",
  total_price: 149.00,
  number_of_rooms: 1,
  description: "Amazing view and perfect location in Alfama",
  remote_photo_url: "https://f22bfca7a5abd176cefa-59c40a19620c1f22577ade10e9206cf5.ssl.cf1.rackcdn.com/u/memmo-alfama-architecture-M-01-r.jpg"
  )
hotel_lisbon_marion.trip = lisbon
hotel_lisbon_marion.participation = marion_lisbon
hotel_lisbon_marion.save!

hotel_lisbon_nina = Accommodation.create(
  name: "Pousada de Lisboa",
  address: "Praça do Comércio 31-34, 1100-148 Lisboa, Portugal",
  start_date: "Fri, 09 Mar 2018",
  end_date: "Mon, 12 Mar 2018",
  status: "Wishlist",
  reference_number: "KODY45",
  number_of_nights: 3,
  phone_number: "+351 21 040 7640",
  url: "https://www.pousadas.pt/en/hotel/pousada-lisboa?utm_medium=organic&utm_source=google&utm_campaign=GoogleMyBusiness",
  email: "pousada@lisbon.com",
  total_price: 475,
  number_of_rooms: 1,
  description: "Luxury hotel with the perfect location",
  remote_photo_url: "https://www.slh.com/globalassets/hotels/p/pousada-de-lisboa/pousadadelisboa_heronew.jpg?width=1024"
  )
hotel_lisbon_nina.trip = lisbon
hotel_lisbon_nina.participation = nina_lisbon
hotel_lisbon_nina.save!

hotel_lisbon_marion = Accommodation.create(
  name: "Pousada de Lisboa",
  address: "Praça do Comércio 31-34, 1100-148 Lisboa, Portugal",
  start_date: "Fri, 09 Mar 2018",
  end_date: "Mon, 12 Mar 2018",
  status: "Wishlist",
  reference_number: "KODY45",
  number_of_nights: 3,
  phone_number: "+351 21 040 7640",
  url: "https://www.pousadas.pt/en/hotel/pousada-lisboa?utm_medium=organic&utm_source=google&utm_campaign=GoogleMyBusiness",
  email: "pousada@lisbon.com",
  total_price: 475,
  number_of_rooms: 1,
  description: "Luxury hotel with the perfect location",
  remote_photo_url: "https://www.slh.com/globalassets/hotels/p/pousada-de-lisboa/pousadadelisboa_heronew.jpg?width=1024"
  )
hotel_lisbon_marion.trip = lisbon
hotel_lisbon_marion.participation = marion_lisbon
hotel_lisbon_marion.save!

puts "Accommodation created"
puts "------"
puts "Creating 25 restaurants"

# restaurant_nyc_nina = Restaurant.create(
#   name: "Balvanera",
#   address: "152 Stanton St, New York, NY 10002, USA",
#   date: "Fri, 04 May 2018 21:00:00 UTC +00:00,",
#   status: "Wishlist",
#   phone_number: "+1 212-533-3348",
#   description: "Argentinian meat",
#   url: "https://www.balvaneranyc.com/",
#   email: "balvanera@newyork.com",
#   remote_photo_url: "https://i.pinimg.com/originals/86/15/3a/86153af2f01f95eabae4e9c60a12ce3c.jpg"
#   )
# restaurant_nyc_nina.trip = nyc
# restaurant_nyc_nina.participation = nina_nyc
# restaurant_nyc_nina.save!

# restaurant_nyc_kenza = Restaurant.create(
#   name: "Balvanera",
#   address: "152 Stanton St, New York, NY 10002, USA",
#   date: "Fri, 04 May 2018 21:00:00 UTC +00:00,",
#   status: "Wishlist",
#   phone_number: "+1 212-533-3348",
#   description: "Argentinian meat",
#   url: "https://www.balvaneranyc.com/",
#   email: "balvanera@newyork.com",
#   remote_photo_url: "https://i.pinimg.com/originals/86/15/3a/86153af2f01f95eabae4e9c60a12ce3c.jpg"
#   )
# restaurant_nyc_kenza.trip = nyc
# restaurant_nyc_kenza.participation = kenza_nyc
# restaurant_nyc_kenza.save!

# restaurant_nyc_elsa = Restaurant.create(
#   name: "Balvanera",
#   address: "152 Stanton St, New York, NY 10002, USA",
#   date: "Fri, 04 May 2018 21:00:00 UTC +00:00,",
#   status: "Wishlist",
#   phone_number: "+1 212-533-3348",
#   description: "Argentinian meat",
#   url: "https://www.balvaneranyc.com/",
#   email: "balvanera@newyork.com",
#   remote_photo_url: "https://i.pinimg.com/originals/86/15/3a/86153af2f01f95eabae4e9c60a12ce3c.jpg"
#   )
# restaurant_nyc_elsa.trip = nyc
# restaurant_nyc_elsa.participation = elsa_nyc
# restaurant_nyc_elsa.save!

restaurant_nyc_nina = Restaurant.create(
  name: "The John Dory Oyster Bar",
  address: "1196 Broadway, New York, NY 10001, USA",
  date: "Fri, 04 May 2018 21:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-792-9000",
  description: "Seafood restaurant Midtown",
  url: "https://www.thejohndory.com/",
  email: "johndory@newyork.com",
  remote_photo_url: "https://getbento.imgix.net/accounts/379950fdceb6e4b055a9692dbfd65e42/mediausers/galleries/images/c3/bYnyflz6SbSnLuJeCiMs_cRdYhuPyTOerbnJbrd3h_rawbarimage.jpg?w=1800&fit=max&auto=compress,format&h=1800"
  )
restaurant_nyc_nina.trip = nyc
restaurant_nyc_nina.participation = nina_nyc
restaurant_nyc_nina.save!

restaurant_nyc_kenza = Restaurant.create(
  name: "The John Dory Oyster Bar",
  address: "1196 Broadway, New York, NY 10001, USA",
  date: "Fri, 04 May 2018 21:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-792-9000",
  description: "Seafood restaurant Midtown",
  url: "https://www.thejohndory.com/",
  email: "johndory@newyork.com",
  remote_photo_url: "https://getbento.imgix.net/accounts/379950fdceb6e4b055a9692dbfd65e42/mediausers/galleries/images/c3/bYnyflz6SbSnLuJeCiMs_cRdYhuPyTOerbnJbrd3h_rawbarimage.jpg?w=1800&fit=max&auto=compress,format&h=1800"
  )
restaurant_nyc_kenza.trip = nyc
restaurant_nyc_kenza.participation = kenza_nyc
restaurant_nyc_kenza.save!

restaurant_nyc_elsa = Restaurant.create(
  name: "The John Dory Oyster Bar",
  address: "1196 Broadway, New York, NY 10001, USA",
  date: "Fri, 04 May 2018 21:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-792-9000",
  description: "Seafood restaurant Midtown",
  url: "https://www.thejohndory.com/",
  email: "johndory@newyork.com",
  remote_photo_url: "https://getbento.imgix.net/accounts/379950fdceb6e4b055a9692dbfd65e42/mediausers/galleries/images/c3/bYnyflz6SbSnLuJeCiMs_cRdYhuPyTOerbnJbrd3h_rawbarimage.jpg?w=1800&fit=max&auto=compress,format&h=1800"
  )
restaurant_nyc_elsa.trip = nyc
restaurant_nyc_elsa.participation = elsa_nyc
restaurant_nyc_elsa.save!

# restaurant_nyc_nina = Restaurant.create(
#   name: "Llama Inn",
#   address: "50 Withers St, Brooklyn, NY 11211, USA",
#   date: "Sat, 05 May 2018 20:00:00 UTC +00:00,",
#   status: "Booked",
#   phone_number: "+1 718-387-3434",
#   description: "Romantic dinner",
#   url: "http://www.llamainnnyc.com/",
#   email: "llamainn@newyork.com",
#   remote_photo_url: "https://idktonight.com/wp-content/uploads/2017/09/LlamaInn.jpg"
#   )
# restaurant_nyc_nina.trip = nyc
# restaurant_nyc_nina.participation = nina_nyc
# restaurant_nyc_nina.save!

# restaurant_nyc_kenza = Restaurant.create(
#   name: "Llama Inn",
#   address: "50 Withers St, Brooklyn, NY 11211, USA",
#   date: "Sat, 05 May 2018 20:00:00 UTC +00:00,",
#   status: "Booked",
#   phone_number: "+1 718-387-3434",
#   description: "Romantic dinner",
#   url: "http://www.llamainnnyc.com/",
#   email: "llamainn@newyork.com",
#   remote_photo_url: "https://idktonight.com/wp-content/uploads/2017/09/LlamaInn.jpg"
#   )
# restaurant_nyc_kenza.trip = nyc
# restaurant_nyc_kenza.participation = kenza_nyc
# restaurant_nyc_kenza.save!

restaurant_nyc_nina = Restaurant.create(
  name: "Lafayette Grand Café & Bakery",
  address: "380 Lafayette St, New York, NY 10003, USA",
  date: "Sun, 06 May 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-533-3000",
  description: "Brunch!!!",
  url: "http://lafayetteny.com/",
  email: "lafayette@newyork.com",
  remote_photo_url: "https://img2.10bestmedia.com/Images/Photos/289775/p-LAFAYETTE-2013-LORES-ADRIAN-1415x925_54_990x660.jpg"
  )
restaurant_nyc_nina.trip = nyc
restaurant_nyc_nina.participation = nina_nyc
restaurant_nyc_nina.save!

restaurant_nyc_kenza = Restaurant.create(
  name: "Lafayette Grand Café & Bakery",
  address: "380 Lafayette St, New York, NY 10003, USA",
  date: "Sun, 06 May 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-533-3000",
  description: "Brunch!!!",
  url: "http://lafayetteny.com/",
  email: "lafayette@newyork.com",
  remote_photo_url: "https://img2.10bestmedia.com/Images/Photos/289775/p-LAFAYETTE-2013-LORES-ADRIAN-1415x925_54_990x660.jpg"
  )
restaurant_nyc_kenza.trip = nyc
restaurant_nyc_kenza.participation = kenza_nyc
restaurant_nyc_kenza.save!

restaurant_nyc_elsa = Restaurant.create(
  name: "Lafayette Grand Café & Bakery",
  address: "380 Lafayette St, New York, NY 10003, USA",
  date: "Sun, 06 May 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-533-3000",
  description: "Brunch!!!",
  url: "http://lafayetteny.com/",
  email: "lafayette@newyork.com",
  remote_photo_url: "https://img2.10bestmedia.com/Images/Photos/289775/p-LAFAYETTE-2013-LORES-ADRIAN-1415x925_54_990x660.jpg"
  )
restaurant_nyc_elsa.trip = nyc
restaurant_nyc_elsa.participation = elsa_nyc
restaurant_nyc_elsa.save!

restaurant_nyc_nina = Restaurant.create(
  name: "Mother's Ruin",
  address: "18 Spring St, New York, NY 10012, USA",
  date: "Sun, 06 May 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 234-768-4000",
  description: "Apparently it is very yumi!",
  url: "http://www.mothersruinnyc.com/",
  email: "mothersruin@newyork.com",
  remote_photo_url: "https://s3-eu-west-1.amazonaws.com/anuevayork/wp-content/uploads/2016/03/16160313/Mejores-brunch-Nueva-York-Mothers-Ruin.jpg"
  )
restaurant_nyc_nina.trip = nyc
restaurant_nyc_nina.participation = nina_nyc
restaurant_nyc_nina.save!

restaurant_nyc_kenza = Restaurant.create(
  name: "Mother's Ruin",
  address: "18 Spring St, New York, NY 10012, USA",
  date: "Sun, 06 May 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 234-768-4000",
  description: "Apparently it is very yumi!",
  url: "http://www.mothersruinnyc.com/",
  email: "mothersruin@newyork.com",
  remote_photo_url: "https://s3-eu-west-1.amazonaws.com/anuevayork/wp-content/uploads/2016/03/16160313/Mejores-brunch-Nueva-York-Mothers-Ruin.jpg"
  )
restaurant_nyc_kenza.trip = nyc
restaurant_nyc_kenza.participation = kenza_nyc
restaurant_nyc_kenza.save!

restaurant_nyc_elsa = Restaurant.create(
  name: "Mother's Ruin",
  address: "18 Spring St, New York, NY 10012, USA",
  date: "Sun, 06 May 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 234-768-4000",
  description: "Apparently it is very yumi!",
  url: "http://www.mothersruinnyc.com/",
  email: "mothersruin@newyork.com",
  remote_photo_url: "https://s3-eu-west-1.amazonaws.com/anuevayork/wp-content/uploads/2016/03/16160313/Mejores-brunch-Nueva-York-Mothers-Ruin.jpg"
  )
restaurant_nyc_elsa.trip = nyc
restaurant_nyc_elsa.participation = elsa_nyc
restaurant_nyc_elsa.save!

restaurant_nyc_nina = Restaurant.create(
  name: "The Garret",
  address: "296 Bleecker St, New York, NY 10014, USA",
  date: "Mon, 07 May 2018 20:30:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-675-6157",
  description: "Speakeasy on Bleecker",
  url: "http://www.garretnyc.com/",
  email: "thegarret@newyork.com",
  remote_photo_url: "https://media.timeout.com/images/102940480/630/472/image.jpg"
  )
restaurant_nyc_nina.trip = nyc
restaurant_nyc_nina.participation = nina_nyc
restaurant_nyc_nina.save!

restaurant_nyc_elsa = Restaurant.create(
  name: "The Garret",
  address: "296 Bleecker St, New York, NY 10014, USA",
  date: "Mon, 07 May 2018 20:30:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 212-675-6157",
  description: "Speakeasy on Bleecker",
  url: "http://www.garretnyc.com/",
  email: "thegarret@newyork.com",
  remote_photo_url: "https://media.timeout.com/images/102940480/630/472/image.jpg"
  )
restaurant_nyc_elsa.trip = nyc
restaurant_nyc_elsa.participation = elsa_nyc
restaurant_nyc_elsa.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "A Cevicheria",
  address: "R. Dom Pedro V 129, 1250-096 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 20:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 803 8815",
  description: "The best restaurant in Lisboa",
  url: "https://www.instagram.com/explore/locations/516570481/a-cevicheria/?hl=en",
  email: "acevicheria@lisbon.com",
  remote_photo_url: "https://media.timeout.com/images/103451712/630/472/image.jpg"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "A Cevicheria",
  address: "R. Dom Pedro V 129, 1250-096 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 20:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 803 8815",
  description: "The best restaurant in Lisboa",
  url: "https://www.instagram.com/explore/locations/516570481/a-cevicheria/?hl=en",
  email: "acevicheria@lisbon.com",
  remote_photo_url: "https://media.timeout.com/images/103451712/630/472/image.jpg"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "Pensão Amor",
  address: "Rua Alecrim 19, 1200-014 Lisboa, Portugal",
  date: "Fri, 09 Mar 2018 22:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 314 3399",
  description: "The craziest and coolest bar in Lisboa",
  url: "http://www.pensaoamor.pt/PT/",
  email: "pensaoamor@lisbon.com",
  remote_photo_url: "https://www.heartofeverywhere.com/wp-content/uploads/2016/11/IMG_6061-1-Cópia.jpg"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "Pensão Amor",
  address: "Rua Alecrim 19, 1200-014 Lisboa, Portugal",
  date: "Fri, 09 Mar 2018 22:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 314 3399",
  description: "The craziest and coolest bar in Lisboa",
  url: "http://www.pensaoamor.pt/PT/",
  email: "pensaoamor@lisbon.com",
  remote_photo_url: "https://www.heartofeverywhere.com/wp-content/uploads/2016/11/IMG_6061-1-Cópia.jpg"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "Time Out Market",
  address: "Av. 24 de Julho 49, 1200-479 Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 12:30:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 395 1274",
  description: "Absolutly amazing!",
  url: "http://www.timeoutmarket.com/",
  email: "timeoutmarket@lisbon.com",
  remote_photo_url: "https://i.pinimg.com/originals/c8/dc/4c/c8dc4c46a58262b9ca743bc1b88b023a.jpg"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "Time Out Market",
  address: "Av. 24 de Julho 49, 1200-479 Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 12:30:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 395 1274",
  description: "Absolutly amazing!",
  url: "http://www.timeoutmarket.com/",
  email: "timeoutmarket@lisbon.com",
  remote_photo_url: "https://i.pinimg.com/originals/c8/dc/4c/c8dc4c46a58262b9ca743bc1b88b023a.jpg"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "BytheWine",
  address: "1200 014, Rua das Flores 41, Portugal",
  date: "Fri, 09 Mar 2018 18:30:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 342 0319",
  description: "Wine bar and tapas",
  url: "http://jmf.pt/index.php?id=375",
  email: "wine@lisbon.com",
  remote_photo_url: "http://lisboacool.com/sites/default/files/styles/ny_article_horizontal__w720xh480_watermark/public/imagens/artigos/lisboa_cool_sair_by_the_wine_27.jpg?itok=2_cX4s_T"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "BytheWine",
  address: "1200 014, Rua das Flores 41, Portugal",
  date: "Fri, 09 Mar 2018 18:30:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 21 342 0319",
  description: "Wine bar and tapas",
  url: "http://jmf.pt/index.php?id=375",
  email: "wine@lisbon.com",
  remote_photo_url: "http://lisboacool.com/sites/default/files/styles/ny_article_horizontal__w720xh480_watermark/public/imagens/artigos/lisboa_cool_sair_by_the_wine_27.jpg?itok=2_cX4s_T"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "Lisboa Tu e Eu",
  address: "R. Adiça 58, 1100-538 Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 19:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 919 485 256",
  description: "Typical portuguese restaurant with a small terrasse",
  url: "http://www.restaurantelisboatueeu.pt/fr_FR/",
  email: "lisboatueeu@lisbon.com",
  remote_photo_url: "https://i1.wp.com/vandamiranda.pt/wp-content/uploads/2017/07/Lisboa-06.jpg"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "Lisboa Tu e Eu",
  address: "R. Adiça 58, 1100-538 Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 19:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+351 919 485 256",
  description: "Typical portuguese restaurant with a small terrasse",
  url: "http://www.restaurantelisboatueeu.pt/fr_FR/",
  email: "lisboatueeu@lisbon.com",
  remote_photo_url: "https://i1.wp.com/vandamiranda.pt/wp-content/uploads/2017/07/Lisboa-06.jpg"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "Quiosque Ribeira das Naus",
  address: "Av. Ribeira das Naus 5, Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 17:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+351 917 427 013",
  description: "Wonderful bar with terrasse to enjoy some sun with Margaritas!",
  url: "https://www.facebook.com/RibeiradasNausLisboa",
  email: "ribeira@lisbon.com",
  remote_photo_url: "https://aperuadetenis.files.wordpress.com/2015/09/dsc_0020.jpg"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "Quiosque Ribeira das Naus",
  address: "Av. Ribeira das Naus 5, Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 17:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+351 917 427 013",
  description: "Wonderful bar with terrasse to enjoy some sun with Margaritas!",
  url: "https://www.facebook.com/RibeiradasNausLisboa",
  email: "ribeira@lisbon.com",
  remote_photo_url: "https://aperuadetenis.files.wordpress.com/2015/09/dsc_0020.jpg"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

restaurant_lisbon_nina = Restaurant.create(
  name: "Pois Café",
  address: "R. de São João da Praça 93-95, 1100-521 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+351 21 886 2497",
  description: "Cafe, bakery & restaurant serving Portuguese-influenced fare.",
  url: "http://www.poiscafe.com/",
  email: "poiscafe@lisbon.com",
  remote_photo_url: "https://www.likealocalguide.com/media/cache/99/97/999757744ce5721bb317584ceda6d901.jpg"
  )
restaurant_lisbon_nina.trip = lisbon
restaurant_lisbon_nina.participation = nina_lisbon
restaurant_lisbon_nina.save!

restaurant_lisbon_marion = Restaurant.create(
  name: "Pois Café",
  address: "R. de São João da Praça 93-95, 1100-521 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 13:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+351 21 886 2497",
  description: "Cafe, bakery & restaurant serving Portuguese-influenced fare.",
  url: "http://www.poiscafe.com/",
  email: "poiscafe@lisbon.com",
  remote_photo_url: "https://www.likealocalguide.com/media/cache/99/97/999757744ce5721bb317584ceda6d901.jpg"
  )
restaurant_lisbon_marion.trip = lisbon
restaurant_lisbon_marion.participation = marion_lisbon
restaurant_lisbon_marion.save!

puts "Restaurant created"
puts "------"
puts "Creating 11 activities"

activity_lisbon_nina = Activity.create(
  name: "Jerónimos Monastery",
  address: "Praça do Império 1400-206 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 10:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "0725366630",
  description: "Former monastery near the Tagus river in the parish of Belém, very famous!",
  url: "http://www.mosteirojeronimos.gov.pt/pt/index.php",
  email: "mosteirojeronimos@lisbon.com",
  remote_photo_url: "https://www.askideas.com/media/81/Balcony-Inside-Jeronimos-Monastery.jpg"
  )
activity_lisbon_nina.trip = lisbon
activity_lisbon_nina.participation = nina_lisbon
activity_lisbon_nina.save!

activity_lisbon_marion = Activity.create(
  name: "Jerónimos Monastery",
  address: "Praça do Império 1400-206 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 10:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "0725366630",
  description: "Former monastery near the Tagus river in the parish of Belém, very famous!",
  url: "http://www.mosteirojeronimos.gov.pt/pt/index.php",
  email: "mosteirojeronimos@lisbon.com",
  remote_photo_url: "https://www.askideas.com/media/81/Balcony-Inside-Jeronimos-Monastery.jpg"
  )
activity_lisbon_marion.trip = lisbon
activity_lisbon_marion.participation = marion_lisbon
activity_lisbon_marion.save!

activity_lisbon_nina = Activity.create(
  name: "Lisbon Go Bike Tour",
  address: "Praça do Comércio, 1100-148 Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 15:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "0744353637",
  description: "Best way to visit Lisbon",
  url: "https://www.viator.com/tours/Lisbon/Lisbon-Hills-Electric-Bike-Tour/d538-5509LSB7EBIKETOUR",
  email: "electricbiketour@lisbon.com",
  remote_photo_url: "http://www.cyclinglisbon.com/wp-content/uploads/2017/03/04-1.jpg"
  )
activity_lisbon_nina.trip = lisbon
activity_lisbon_nina.participation = nina_lisbon
activity_lisbon_nina.save!

activity_lisbon_marion = Activity.create(
  name: "Lisbon Go Bike Tour",
  address: "Praça do Comércio, 1100-148 Lisboa, Portugal",
  date: "Sun, 11 Mar 2018 15:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "0744353637",
  description: "Best way to visit Lisbon",
  url: "https://www.viator.com/tours/Lisbon/Lisbon-Hills-Electric-Bike-Tour/d538-5509LSB7EBIKETOUR",
  email: "electricbiketour@lisbon.com",
  remote_photo_url: "http://www.cyclinglisbon.com/wp-content/uploads/2017/03/04-1.jpg"
  )
activity_lisbon_marion.trip = lisbon
activity_lisbon_marion.participation = marion_lisbon
activity_lisbon_marion.save!

activity_lisbon_nina = Activity.create(
  name: "Museu do Fado",
  address: "Largo Chafariz de Dentro 1, 1100-139 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 09:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+351 21 882 3470",
  description: "Museum of the typical Portuguese dance, a must see!",
  url: "http://www.museudofado.pt/",
  email: "museufado@lisbon.com",
  remote_photo_url: "https://itinari.imgix.net/activity/images/original/f49f1a80-848b-47ad-adf4-c6525d30e587-museu-do-fado-2-2x.jpg?fm=pjpg&ch=DPR&dpr=2&w=800&fit=clip&trim=auto&auto=enhance"
  )
activity_lisbon_nina.trip = lisbon
activity_lisbon_nina.participation = nina_lisbon
activity_lisbon_nina.save!

activity_lisbon_marion = Activity.create(
  name: "Museu do Fado",
  address: "Largo Chafariz de Dentro 1, 1100-139 Lisboa, Portugal",
  date: "Sat, 10 Mar 2018 09:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+351 21 882 3470",
  description: "Museum of the typical Portuguese dance, a must see!",
  url: "http://www.museudofado.pt/",
  email: "museufado@lisbon.com",
  remote_photo_url: "https://itinari.imgix.net/activity/images/original/f49f1a80-848b-47ad-adf4-c6525d30e587-museu-do-fado-2-2x.jpg?fm=pjpg&ch=DPR&dpr=2&w=800&fit=clip&trim=auto&auto=enhance"
  )
activity_lisbon_marion.trip = lisbon
activity_lisbon_marion.participation = marion_lisbon
activity_lisbon_marion.save!

activity_nyc_nina = Activity.create(
  name: "Guggenheim Museum",
  address: "1071 5th Ave, New York, NY 10128, USA",
  date: "Fri, 04 May 2018 14:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+1 278-214-5000",
  description: "Unmissable",
  url: "https://www.guggenheim.org/",
  email: "guggenheim@newyork.com",
  remote_photo_url: "https://images.adsttc.com/media/images/5755/2501/e58e/ceff/0900/065d/large_jpg/copyright_laurian_ghinitoiu_guggenheim_ny_(18_of_30).jpg?1465197822"
  )
activity_nyc_nina.trip = nyc
activity_nyc_nina.participation = nina_nyc
activity_nyc_nina.save!

activity_nyc_elsa = Activity.create(
  name: "Guggenheim Museum",
  address: "1071 5th Ave, New York, NY 10128, USA",
  date: "Fri, 04 May 2018 14:00:00 UTC +00:00,",
  status: "Booked",
  phone_number: "+1 278-214-5000",
  description: "Unmissable",
  url: "https://www.guggenheim.org/",
  email: "guggenheim@newyork.com",
  remote_photo_url: "https://images.adsttc.com/media/images/5755/2501/e58e/ceff/0900/065d/large_jpg/copyright_laurian_ghinitoiu_guggenheim_ny_(18_of_30).jpg?1465197822"
  )
activity_nyc_elsa.trip = nyc
activity_nyc_elsa.participation = elsa_nyc
activity_nyc_elsa.save!

activity_nyc_nina = Activity.create(
  name: "Brooklyn Brewery",
  address: "79 N 11th St, Brooklyn, NY 11249, USA",
  date: "Mon, 04 May 2018 17:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 718-486-7422",
  description: "Can we go there please please please!???",
  url: "http://brooklynbrewery.com/verify",
  email: "brooklynbrewery@newyork.com",
  remote_photo_url: "https://cdn.viewing.nyc/assets/media/0b4fc8f7c444dc7fbd7bf03c095990d3/elements/491efb64e8b635a8c20da968987ebfdc/xl/8acd8050-2dbd-4069-887f-be3709cc7fd0_2x.jpg"
  )
activity_nyc_nina.trip = nyc
activity_nyc_nina.participation = nina_nyc
activity_nyc_nina.save!

activity_nyc_kenza = Activity.create(
  name: "Brooklyn Brewery",
  address: "79 N 11th St, Brooklyn, NY 11249, USA",
  date: "Mon, 04 May 2018 17:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 718-486-7422",
  description: "Can we go there please please please!???",
  url: "http://brooklynbrewery.com/verify",
  email: "brooklynbrewery@newyork.com",
  remote_photo_url: "https://cdn.viewing.nyc/assets/media/0b4fc8f7c444dc7fbd7bf03c095990d3/elements/491efb64e8b635a8c20da968987ebfdc/xl/8acd8050-2dbd-4069-887f-be3709cc7fd0_2x.jpg"
  )
activity_nyc_kenza.trip = nyc
activity_nyc_kenza.participation = kenza_nyc
activity_nyc_kenza.save!

activity_nyc_elsa = Activity.create(
  name: "Brooklyn Brewery",
  address: "79 N 11th St, Brooklyn, NY 11249, USA",
  date: "Mon, 04 May 2018 17:00:00 UTC +00:00,",
  status: "Wishlist",
  phone_number: "+1 718-486-7422",
  description: "Can we go there please please please!???",
  url: "http://brooklynbrewery.com/verify",
  email: "brooklynbrewery@newyork.com",
  remote_photo_url: "https://cdn.viewing.nyc/assets/media/0b4fc8f7c444dc7fbd7bf03c095990d3/elements/491efb64e8b635a8c20da968987ebfdc/xl/8acd8050-2dbd-4069-887f-be3709cc7fd0_2x.jpg"
  )
activity_nyc_elsa.trip = nyc
activity_nyc_elsa.participation = elsa_nyc
activity_nyc_elsa.save!

puts "Activity created"
puts "------"
puts "Finished!"
