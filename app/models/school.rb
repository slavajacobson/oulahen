class School < ActiveRecord::Base
  belongs_to :neighbourhood

  validates :neighbourhood, presence: true
end
