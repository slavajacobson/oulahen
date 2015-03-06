class SlideShowImage < ActiveRecord::Base
	mount_uploader :image, SlideShowImageUploader
end
