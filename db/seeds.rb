# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Cleaning database now...'
Booking.destroy_all
Truck.destroy_all
User.destroy_all
puts 'Database clean ✅'

# Users:

user = User.new
user.email = 'admin@gmail.com' # admin user
user.password = '123456'
user.name = "Administator"
user.admin = true
user.save!

user_rentee = User.new
user_rentee.email = 'joe@gmail.com' # user_rentee to rent a truck
user_rentee.password = '123456'
user_rentee.name = "Joe Rentee"
user_rentee.save!

user = User.new
user.email = 'owner@gmail.com' # user to offer trucks
user.name = "Anne Owner"
user.password = '123456'
user.save!

# Trucks:

truck_array = []

10.times do 
  truck = Truck.new(
    title: Faker::Vehicle.make_and_model,
    location: ['Berlin - Mitte', 'Berlin - Kreuzberg', 'Berlin - Tiergarten'].sample,
    size: ['Large SUV', 'Pick-Up Truck', 'Small Van', 'Large Van'].sample,
    price_per_day: rand(25..100),
    description: Faker::Lorem.paragraph(sentence_count: 2),
  )
  truck.user = user
  truck.save
  truck_array << truck
end

# Bookings:

5.times do
  random_day = rand(19..30)
  booking = Booking.new(
    start_date:  DateTime.new(2020, 11, 18), # Date.parse("18/11/2020")
    end_date: DateTime.new(2020, 11, random_day),
    status: ['pending', 'confirmed', 'pending'].sample,
  )
  booking.user = user_rentee
  booking.truck = truck_array.sample
  booking.save
  p booking
end

puts "Done!"
puts "Created #{User.count} users."
puts "Created #{Truck.count} trucks."
puts "Created #{Booking.count} bookings."



