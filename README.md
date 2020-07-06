# README

Railsland Jaguar

The project was to develop a vehicle service appointments application for Railsland Jaguar, a new car dealership that commences operation on July 15, 2020. Users (dealer customer service staff) can in response to a customer's in-person or telephone request, create a customer account and/or set up a service appointment. The app aslo has functionalities for users to perform CRUD operations on services and users data depending on their user role. Access to the application is through custom sign-up and sign-in as well as through facebook authentication.
 
- Architecture and models
The application has 5 models - Dealer, User, Customer, Service and Appointment. The Dealer model is the main model that has many users, customers and services. The Customer and Service models represent a many-to-many relationship, and are joined through their child model - Appointment. 
 
- Development
The application was developed using Ruby 2.6 and Rails 6
 
- Clone the application:
run “git clone git@github.com:coula3/railsland-jaguar.git”
cd “railsland-jaguar”
 
- Install bundler
run “gem install bundler”
run “bundle install”
 
- Database set up 
run “rails db:migrate RAILS_ENV=development”

- Seed database
run “rails db:seed”
 
- Start the Rails Server:
run “rails s”
 
- Launch the application:
visit “http://localhost:3000”