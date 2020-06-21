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

# USER ***
# User.create(first_name: "Josh", last_name: "Powers", email: "jpowers@rjaguar.com", dealer_id: Dealer.first.id)
# puts "User successfully created" if User.first

# SERVICE ***
# services = ["routine maintenance", "inspection", "electronics-system", "air-conditioning"]

# services.each do |service|
#     Service.create(name: service, dealer_id: Dealer.first.id)
# end
# puts "#{Service.count} services successfully created!" if Service.count == services.count

c = 4
c.times do
    Customer.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name, telephone: "555-#{rand(100..999)}-#{rand(1000..9999)}", dealer_id: Dealer.first.id)
end
puts "#{Customer.count} users successfully created!" if Customer.count == c