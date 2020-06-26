# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# DEALER ***
# Dealer.create(name: "Railsland Jaguar")
# puts "Dealer successfully created" if Dealer.first

## USER ***
# User.create(first_name: "Josh", last_name: "Powers", email: "jpowers@rjaguar.com", dealer_id: Dealer.first.id)
# puts "User successfully created" if User.first

## SERVICE ***
Service.destroy_all
services = ["Routine Maintenance", "Tire Pressure Light", "5000 Miles Service", "Major Service", "Recall", "State Inspection", "Electronics System", "Air-Conditioning"]

services.each do |service|
    Service.create(name: service, dealer_id: Dealer.first.id)
end
puts "#{Service.count} services successfully created!" if Service.count == services.count

## CUSTOMER ***
# c = 4
# c.times do
#     Customer.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, telephone: "555-#{rand(100..999)}-#{rand(1000..9999)}", dealer_id: Dealer.first.id)
# end
# puts "#{Customer.count} users successfully created!" if Customer.count == c

## APPOINTMENT
# t = Time.now
# models = ["Jaguar F-TYPE", "Jaguar XE", "Jaguar XE SV", "Jaguar XF", "Jaguar XJ", "Jaguar E-PACE", "Jaguar F-PACE", "Jaguar I-PACE"]
# m_years =  ((t.year - 10)..t.year).to_a

# a = 10
# a.times do
#     Appointment.create(date: Time.new(2020, 7, rand(15..18), 20, 0, 0), time: Time.new(2020, 7, 15, 4, 0) + (60 * 60 * rand(10) + [15*60, 30*60, 45*60].sample), veh_model: models.sample, model_year: m_years.sample, customer_id: Customer.all.sample.id, service_id: Service.all.sample.id)
# end
# puts "#{Appointment.count} appointments successfully created!" if Appointment.count == a

# Customer.all.each do |cust|
#     cust.update(email: cust.first_name.slice(0).downcase.concat("@").concat(cust.last_name.downcase).concat(".com"))
# end
# puts "#{Customer.count} appointments successfully updated!" if Customer.count == Customer.count {|cust| cust.email}