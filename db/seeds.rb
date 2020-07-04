# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# DEALER ***
# Dealer.destroy_all
Dealer.create(name: "Railsland Jaguar", address: "1010 Ruby Boulevard", city: "Railsland", state: "New Devshire", zip: "99999", telephone: "555-505-0550")
puts "Dealer successfully created!" if Dealer.first

dealer = Dealer.first

# USER ***
# User.destroy_all
u = 2
u.times do
    user = dealer.users.build(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, password: "123", status: "active")
    user.email = user.first_name.slice(0).downcase.concat(user.last_name.downcase).concat("@rjaguar.com")
    user.save
end
puts "#{User.count} users successfully created!" if User.count == u

User.first.update(admin: true)
puts "User first admin update successful!" if User.first.admin

# SERVICE ***
# Service.destroy_all
services = ["5000 Miles Service", "Air-Conditioning", "Electronics System", "Major Service", "Recall", "Routine Maintenance", "State Inspection", "Tire Pressure Light"]

services.each do |service|
    dealer.services.create(name: service)
end
puts "#{Service.count} services successfully created!" if Service.count == services.size

# CUSTOMER ***
c = 5
c.times do
    customer = dealer.customers.build(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, telephone: "555-#{rand(100..999)}-#{rand(1000..9999)}")
    customer.email = customer.first_name.slice(0).downcase.concat("@").concat(customer.last_name.downcase).concat(".com")
    customer.save
end
puts "#{Customer.count} customers successfully created!" if Customer.count == c

# APPOINTMENT ***
t = Time.now
models = ["Jaguar F-TYPE", "Jaguar XE", "Jaguar XE SV", "Jaguar XF", "Jaguar XJ", "Jaguar E-PACE", "Jaguar F-PACE", "Jaguar I-PACE"]
m_years =  ((t.year - 10)..t.year).to_a

a = 15
a.times do
    Appointment.create(date: Time.new(2020, 7, rand(15..18), 20, 0, 0), time: Time.new(2020, 7, 15, 4, 0) + (60 * 60 * rand(10) + [15*60, 30*60, 45*60].sample), veh_model: models.sample, model_year: m_years.sample, customer_id: Customer.all.sample.id, service_id: Service.all.sample.id)
end
puts "#{Appointment.count} appointments successfully created!" if Appointment.count == a