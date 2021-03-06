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



Neighbourhood.create(image: Rails.root.join("db/files/1.jpg").open, name: 'Yonge & Finch', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis fuga beatae quaerat dolor porro perspiciatis rerum, temporibus, ipsum repellat, aliquid nisi itaque sunt. Omnis temporibus, mollitia odit voluptate dolor dolorem?', condo_apts: rand(50), detached: rand(50), condo_towns: rand(50), condo_other: rand(50))
Neighbourhood.create(image: Rails.root.join("db/files/1.jpg").open, name: 'Yonge & Sheppard', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis fuga beatae quaerat dolor porro perspiciatis rerum, temporibus, ipsum repellat, aliquid nisi itaque sunt. Omnis temporibus, mollitia odit voluptate dolor dolorem?', condo_apts: rand(50), detached: rand(50), condo_towns: rand(50), condo_other: rand(50))
Neighbourhood.create(image: Rails.root.join("db/files/1.jpg").open, name: 'Avondale', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis fuga beatae quaerat dolor porro perspiciatis rerum, temporibus, ipsum repellat, aliquid nisi itaque sunt. Omnis temporibus, mollitia odit voluptate dolor dolorem?', condo_apts: rand(50), detached: rand(50), condo_towns: rand(50), condo_other: rand(50))
Neighbourhood.create(image: Rails.root.join("db/files/1.jpg").open, name: 'Bayview & Sheppard', description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis fuga beatae quaerat dolor porro perspiciatis rerum, temporibus, ipsum repellat, aliquid nisi itaque sunt. Omnis temporibus, mollitia odit voluptate dolor dolorem?', condo_apts: rand(50), detached: rand(50), condo_towns: rand(50), condo_other: rand(50))



30.times do |i|
  School.create(name: "School Name Public School", neighbourhood_id: Random.rand(3) + 1)
end

User.create(email:'vs.jacobson@gmail.com', password:'12344321', password_confirmation:'12344321')
User.create(email:'team@oulahen.com', password:'oulahen1234!@#$', password_confirmation:'oulahen1234!@#$')

total_neighbourhoods = Neighbourhood.count


70.times do |i|


  street_number = 1 + Random.rand(300)
  street_names = ['Islington Road','Bathurst Street','Steeles Avenue','Weston Road', 'Yonge Street','King Street', 'Queen Street', 'Bloor Street', 
                  'Finch Street', 'Allen Road', 'Dufferin Street', 'Brett Avenue', 'Hoover Crescent', 'Macnaughton Road','Pawnee Avenue', 'Stafford Road', 
                  'Valentine Drive', 'Valey Crescent']

  address = street_number.to_s + ' ' + street_names[Random.rand(street_names.length)]


  condo_profile = CondoProfile.create!(address: address, draft:false, neighbourhood: Neighbourhood.offset(rand(total_neighbourhoods)).first, total_rented: rand(350), total_owned: rand(350))
  
  photo = Photo.create!(image: Rails.root.join("db/files/1.jpg").open, featured: (Random.rand(2) == 0 ? false : true), main_photo: true)


  condo_profile.photos << photo
  condo_profile.save!
  print "#{i}-"

end


100.times do |i|

  #get random condo profile
  condo_profile = CondoProfile.offset(rand(CondoProfile.count)).first


  street_number = condo_profile.address.scan( /^\d+/ ).first #1 + Random.rand(300)
  #street_names = ['Islington Road','Bathurst Street','Steeles Avenue','Weston Road', 'Yonge Street','King Street', 'Queen Street', 'Bloor Street', 'Finch Street', 'Allen Road', 'Dufferin Street', 'Brett Avenue', 'Hoover Crescent', 'Macnaughton Road','Pawnee Avenue', 'Stafford Road', 'Valentine Drive', 'Valey Crescent']

  street = condo_profile.address.scan( /[a-zA-Z ]+/ ).first.strip #street_names[Random.rand(street_names.length)]
  unit_number = 1 + Random.rand(1000)
  show_unit_number = Random.rand(2) == 1 ? true : false
  property_sold = Random.rand(2) == 1 ? true : false

  profile = condo_profile.id #Random.rand(3) + 1



  Listing.create(address: street, street_number: street_number.to_s, unit_number:show_unit_number ? unit_number.to_s : '', postal_code:'X1X1X', neighbourhood: 'Awesome!', 
               lot: '40', sqft:'1500', bedrooms:'3+1',bathrooms:'4', price:750000, sold:false, maintenance_fee:600, sold: property_sold,
               virtual_tour_url:'http://www.google.ca/?gws_rd=cr', map_url:'http://www.google.ca/?gws_rd=cr', realtor_url:'http://www.google.ca/?gws_rd=cr',
               facebook_url:'http://www.google.ca/?gws_rd=cr', description:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
               inclusions:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor', city_province: 'Toronto, Ontario',
               exclusions:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor', draft:false, condo_profile_id: profile, category_id: 2)
  print "#{i}-"

end

# pi = ProductImage.create!(:product => product)
# pi.image.store!(File.open(File.join(Rails.root, 'test.jpg')))
# product.product_images << pi
# product.save!


# restaurant = Restaurant.create!(name: "McDonald's")
# restaurant.logo = Rails.root.join("db/images/mcdonalds_logo.png").open
# restaurant.save!



amenities_folder = "#{Rails.root}/db/files/amenities"
puts "folder is " + amenities_folder
Dir.glob("#{amenities_folder}/*.jpg") do |file|

  label = File.basename(file, ".*")
  amenity = Amenity.create!(label: label, icon: Rails.root.join(file).open)

end


maintenance_folder = "#{Rails.root}/db/files/maintenance"
puts "folder is " + maintenance_folder
Dir.glob("#{maintenance_folder}/*.jpg") do |file|

  label = File.basename(file, ".*")
  maintenance = Maintenance.create!(label: label, icon: Rails.root.join(file).open)

end



team_photos_folder = "#{Rails.root}/db/files/team_photos"
puts "folder is " + team_photos_folder
Dir.glob("#{team_photos_folder}/*.jpg") do |file|

  label = File.basename(file, ".*")
  team_photos = TeamPhoto.create!(image: Rails.root.join(file).open)

end