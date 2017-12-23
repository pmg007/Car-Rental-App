# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([ {email: 'user1@test.com', password: '1234567', password_confirmation:	'1234567', role: 'customer', name: 'customer1', rental: 0}])
 User.create([ {email: 'zaheen1@test.com', password: '1234567', password_confirmation:	'1234567', role: 'superadmin', name: 'Zaheen1', rental: 0}])
User.create([ {email: 'user2@test.com', password: '1234567', password_confirmation:	'1234567', role: 'customer', name: 'customer2', rental: 0}])
User.create([ {email: 'admin1@test.com', password: '1234567', password_confirmation:	'1234567', role: 'admin', name: 'admin1', rental: 0}])
User.create([ {email: 'admin2@test.com', password: '1234567', password_confirmation:	'1234567', role: 'admin', name: 'admin2', rental: 0}])
User.create([ {email: 'superadmin2@test.com', password: '1234567', password_confirmation:	'1234567', role: 'superadmin', name: 'superadmin2', rental: 0}])

Car.create([{model: 'civic', manufacturer: 'Honda', rate: '10', status: 'AVAILABLE', license: '1232312', style: 'Sedan', location: 'Raleigh'}])
Car.create([{model: 'civic', manufacturer: 'Honda', rate: '10', status: 'AVAILABLE', license: '1232512', style: 'Sedan', location: 'New york'}])
Car.create([{model: 'Accord', manufacturer: 'Honda', rate: '10', status: 'AVAILABLE', license: '1232342', style: 'Sedan', location: 'Raleigh'}])
Car.create([{model: 'spark', manufacturer: 'Chevrolet', rate: '15', status: 'AVAILABLE', license: '1232362', style: 'Hatchback', location: 'Ann Arbor'}])
Car.create([{model: 'Suburban', manufacturer: 'Chevrolet', rate: '20', status: 'AVAILABLE', license: '1332362', style: 'SUV', location: 'New york'}])
Car.create([{model: 'Highlander', manufacturer: 'Toyota', rate: '50', status: 'AVAILABLE', license: '1339362', style: 'SUV', location: 'Raleigh'}])
