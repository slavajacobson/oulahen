# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name:'Home')
Category.create(name:'Condominium')
Category.create(name:'Commercial')

User.create(email:'vs.jacobson@gmail.com', password:'12344321', password_confirmation:'12344321')