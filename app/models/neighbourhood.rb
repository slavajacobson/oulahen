class Neighbourhood < ActiveRecord::Base
  has_many :condo_profiles
  has_many :schools
  #serialize :schools
  validates :slug, uniqueness: true, presence: true
  before_validation :generate_slug

  mount_uploader :image, ImageUploader

  def to_param
    slug
  end

  def generate_slug

    new_slug = name

    #prevent slug duplicates
    #if slug is the same as original, move on.
    unless self.slug == new_slug.parameterize
      i = 1
      while true
        @existing_slug = Neighbourhood.find_by_slug(new_slug.parameterize)
        break if @existing_slug.nil? || @existing_slug == self
        new_slug = new_slug + '-#{i}'
        i = i + 1
      end
    end


    self.slug = new_slug.parameterize

  end
end
