class Amenity < ActiveRecord::Base
  #belongs_to :condo_profile
  mount_uploader :icon, AmenityIconUploader
end
