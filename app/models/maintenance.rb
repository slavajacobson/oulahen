class Maintenance < ActiveRecord::Base
  mount_uploader :icon, AmenityIconUploader
end
