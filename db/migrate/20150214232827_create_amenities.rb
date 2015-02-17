class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.references :condo_profile, index: true
      t.string :label
      t.string :amenity_icon
      
      t.timestamps
    end
  end
end
