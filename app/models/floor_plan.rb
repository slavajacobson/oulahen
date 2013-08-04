class FloorPlan < ActiveRecord::Base
	belongs_to :listing
	mount_uploader :file, PdfUploader
end
