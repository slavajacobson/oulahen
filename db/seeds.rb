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

500.times do |i|


street_number = 1 + Random.rand(300)
street_names = ['Islington Road','Bathurst Street','Steeles Avenue','Weston Road', 'Yonge Street','King Street', 'Queen Street', 'Bloor Street', 
								'Finch Street', 'Allen Road', 'Dufferin Street', 'Brett Avenue', 'Hoover Crescent', 'Macnaughton Road','Pawnee Avenue', 'Stafford Road', 
								'Valentine Drive', 'Valey Crescent']

street = street_names[Random.rand(street_names.length)]
unit_number = 1 + Random.rand(1000)
show_unit_number = Random.rand(2) == 1 ? true : false
property_sold = Random.rand(2) == 1 ? true : false

	Listing.create(address: street, street_number: street_number.to_s, unit_number:show_unit_number ? unit_number.to_s : '', postal_code:'X1X1X', neighbourhood: 'Awesome!', 
							 lot: '40', sqft:'1500', bedrooms:'3+1',bathrooms:'4', price:750000, sold:false, maintenance_fee:600, sold: property_sold,
							 virtual_tour_url:'http://www.google.ca/?gws_rd=cr', map_url:'http://www.google.ca/?gws_rd=cr', realtor_url:'http://www.google.ca/?gws_rd=cr',
							 facebook_url:'http://www.google.ca/?gws_rd=cr', description:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
							 inclusions:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor', city_province: 'Toronto, Ontario',
							 exclusions:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor', draft:false, category_id: Random.rand(3) + 1)
	print "#{i}-"

end


