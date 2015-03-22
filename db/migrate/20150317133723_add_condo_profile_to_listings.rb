class AddCondoProfileToListings < ActiveRecord::Migration
  def change
  	add_reference :listings, :condo_profile, index: true
  end
end
