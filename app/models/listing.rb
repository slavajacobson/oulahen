class Listing < ActiveRecord::Base
	has_one :floor_plan
	has_one :feature_sheet
	has_many :photos, dependent: :destroy
	belongs_to :category


	accepts_nested_attributes_for :floor_plan, allow_destroy: true
	accepts_nested_attributes_for :feature_sheet, allow_destroy: true
	#accepts_nested_attributes_for :photos, allow_destroy: true
end
