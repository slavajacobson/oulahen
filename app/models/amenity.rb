class Amenity < ActiveRecord::Base
  #belongs_to :condo_profile
  mount_uploader :amenity_icon, AmenityIconUploader
end
