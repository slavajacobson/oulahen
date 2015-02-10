class FloorPlan < ActiveRecord::Base
	belongs_to :listing
  belongs_to :condo_profile
	mount_uploader :file, PdfUploader
end
