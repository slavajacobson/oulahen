class Photo < ActiveRecord::Base
	belongs_to :listing
  belongs_to :team_member
  belongs_to :condo_profile
  
	mount_uploader :image, ImageUploader
end
