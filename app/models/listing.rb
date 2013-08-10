class Listing < ActiveRecord::Base

	before_validation :generate_slug


	validates :slug, uniqueness: true, presence: true

	has_one :floor_plan
	has_one :feature_sheet
	has_many :photos, dependent: :destroy
	belongs_to :category


	accepts_nested_attributes_for :floor_plan, allow_destroy: true
	accepts_nested_attributes_for :feature_sheet, allow_destroy: true
	#accepts_nested_attributes_for :photos, allow_destroy: true



	def to_param
		slug
	end

	def generate_slug
		if draft
			self.slug ||= Random.rand(9999999999999)
		else
			new_slug = ""

			# unless unit_number.blank?
			# 	new_slug = unit_number + '-'
			# end

			unless street_number.blank?
				new_slug = new_slug + street_number
			end
			unless address.blank?
				new_slug = new_slug + '-' + address
			end
			unless city_province.blank?
				new_slug = new_slug + '-' + city_province
			end


			#prevent slug duplicates
			#if slug is the same as original, move on.
			unless self.slug == new_slug.parameterize
				i = 1
				while true
					@existing_slug = Listing.find_by_slug(new_slug.parameterize)
					break if @existing_slug.nil? || @existing_slug == self
					new_slug = new_slug + '-#{i}'
					i = i + 1
				end
			end


			self.slug = new_slug.parameterize
		end
	end

end
