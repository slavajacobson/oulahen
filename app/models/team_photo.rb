class TeamPhoto < ActiveRecord::Base
	mount_uploader :image, SlideShowImageUploader
end
