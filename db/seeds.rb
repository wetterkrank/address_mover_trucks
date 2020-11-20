# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'csv'
require "open-uri"

puts 'Cleaning database now...'
Booking.destroy_all
Truck.destroy_all
User.destroy_all
puts 'Database clean ✅'

# Users:

owner_array = []

user = User.new
user.email = 'admin@gmail.com' # admin user
user.password = '123456'
user.name = "Administator"
user.admin = true
user.save!

user_rentee = User.new
user_rentee.email = 'joe@gmail.com' # user_rentee to rent a truck
user_rentee.password = '123456'
user_rentee.name = "Kim Kardashian"
user_rentee.save!

user_owner = User.new
user_owner.email = 'anne.owner@gmail.com' # user_owner1 to offer trucks
user_owner.name = "Anne Owner"
user_owner.password = '123456'
user_owner.save!

user_owner2 = User.new
user_owner2.email = 'anne.other.owner@gmail.com'
user_owner2.name = "Anne Other Owner"
user_owner2.password = '123456'
user_owner2.save!


# Trucks:
truck_array = []

csv_text = File.read(Rails.root.join('lib', 'seeds_db', 'our_trucks_seeds.csv'))
csv = CSV.parse(csv_text, :headers => true, :header_converters => :symbol)
csv.each do |row|
  p row
  t = Truck.new
  t.title = row[:title]
  t.location = row[:location]
  t.size = row[:size]
  t.price_per_day = row[:price_per_day]
  t.description = row[:description]

  file = URI.open(row[:photo_url])
  t.photos.attach(io: file, filename: 'picture')
 
  t.user = user_owner
  t.save
  truck_array << t
end



# Bookings:

3.times do
  random_day = rand(19..30)
  booking = Booking.new(
    start_date:  DateTime.new(2020, 11, 18), # Date.parse("18/11/2020")
    end_date: DateTime.new(2020, 11, random_day),
    status: ['pending', 'confirmed', 'pending'].sample,
  )
  booking.user = user_rentee
  booking.truck = truck_array.sample
  booking.save
end

puts "Done!"
puts "Created #{User.count} users."
puts "Created #{Truck.count} trucks."
puts "Created #{Booking.count} bookings."



