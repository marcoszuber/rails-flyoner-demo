# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Aircraft.destroy_all
User.destroy_all
Booking.destroy_all

puts "Creating with faker"
users = []
aircrafts = []

5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456adasdasd*",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dni: Faker::IDNumber.spanish_citizen_number
  )
  users << user[:id]
end

5.times do
  aircraft = Aircraft.create!(
    name: Faker::Vehicle.make_and_model,
    seats: rand(1..10),
    price: rand(100..1000),
    description: Faker::Lorem.paragraph,
    user_id: users.sample
  )
  aircrafts << aircraft[:id]
end



5.times do
  Booking.create!(
    start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    finish_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1),
    user_id: users.sample,
    aircraft_id: aircrafts.sample
  )
end
puts "Finished"
