# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database now..."
User.destroy_all
puts "Database clean ✅"



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


puts "Done! Created #{User.count} users."
