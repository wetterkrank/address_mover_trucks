# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Cleaning database now...'
Truck.destroy_all
User.destroy_all
puts 'Database clean ✅'

user = User.new
user.email = 'christoph.harlander@hotmail.com'
user.password = '123456'
user.save!

user = User.new
user.email = 'hola.harlander@hotmail.com'
user.password = '123456'
user.save!

user = User.new
user.email = 'chau.harlander@gmail.com'
user.password = '123456'
user.save!

10.times do 
  truck = Truck.new(
    title: Faker::Vehicle.make_and_model,
    location: ['Berlin', 'Hamburg', 'Munich'].sample,
    size: ['Large SUV', 'Pick-Up Truck', 'Small Van', 'Large Van'].sample,
    price_per_day: rand(2500..10000),
    description: Faker::Lorem.paragraph(sentence_count: 2),
  )
  truck.user = user
  truck.save
end

puts "Done! Created #{User.count} users."
puts "Created #{Truck.count} trucks."
