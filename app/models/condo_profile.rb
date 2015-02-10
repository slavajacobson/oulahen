class CondoProfile < ActiveRecord::Base

  has_many :photos

  before_validation :generate_slug


  validates :slug, uniqueness: true, presence: true
  belongs_to :category
  has_one :floor_plan
  accepts_nested_attributes_for :floor_plan, allow_destroy: true

  
  def to_param
    slug
  end

  def generate_slug
    #debugger
    if draft
      self.slug ||= Random.rand(9999999999999)
    else
      new_slug = address


      #prevent slug duplicates
      #if slug is the same as original, move on.
      unless self.slug == new_slug.parameterize
        i = 1
        while true
          @existing_slug = CondoProfile.find_by_slug(new_slug.parameterize)
          break if @existing_slug.nil? || @existing_slug == self
          new_slug = new_slug + '-#{i}'
          i = i + 1
        end
      end


      self.slug = new_slug.parameterize
    end
  end
end
