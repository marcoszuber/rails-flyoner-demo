# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Booking.destroy_all
User.destroy_all
Aircraft.destroy_all

puts "Creating with faker"
users = []
aircrafts = []

6.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456adasdasd*",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dni: Faker::IDNumber.spanish_citizen_number
  )
  users << user[:id]
end

6.times do
  aircraft = Aircraft.create!(
    name: Faker::Vehicle.make_and_model,
    seats: rand(1..10),
    price: rand(100..1000),
    description: Faker::Lorem.paragraph,
    user_id: users.sample
  )
  aircraft_photo = URI.open("http://images.unsplash.com/photo-1597110680197-4dd3469a5270?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")
  aircraft.photos.attach(io: aircraft_photo, filename: "aircraft_1.jpg", content_type: "image/jpg")
  aircrafts << aircraft[:id]
end



6.times do
  Booking.create!(
    start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    finish_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1),
    user_id: users.sample,
    aircraft_id: aircrafts.sample
  )
end
puts "Finished"
