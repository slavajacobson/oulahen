class AddCondoProfileReferenceToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :condo_profile, index: true
  end
end
