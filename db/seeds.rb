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
puts 'Database clean ✅'

10.times do 
  Truck.create!(
    title: Faker::Vehicle.make_and_model,
    location: ['Berlin', 'Hamburg', 'Munich'].sample,
    size: ['Large SUV', 'Pick-Up Truck', 'Small Van', 'Large Van'].sample,
    price_per_day: rand(25..100),
    description: Faker::Lorem.paragraph(sentence_count: 2),
  )
end

puts "Done! Created #{Truck.count} trucks."
