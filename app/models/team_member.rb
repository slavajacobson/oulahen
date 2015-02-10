class TeamMember < ActiveRecord::Base
  has_many :custom_fields
  has_many :photos
  accepts_nested_attributes_for :custom_fields, allow_destroy: true



  before_validation :generate_slug


  validates :slug, uniqueness: true, presence: true


  def to_param
    slug
  end

  def generate_slug
    if draft
      self.slug ||= Random.rand(9999999999999)
    else
      new_slug = name


      #prevent slug duplicates
      #if slug is the same as original, move on.
      unless self.slug == new_slug.parameterize
        i = 1
        while true
          @existing_slug = TeamMember.find_by_slug(new_slug.parameterize)
          break if @existing_slug.nil? || @existing_slug == self
          new_slug = new_slug + '-#{i}'
          i = i + 1
        end
      end


      self.slug = new_slug.parameterize
    end
  end
end
