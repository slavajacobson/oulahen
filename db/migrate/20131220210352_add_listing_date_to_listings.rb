class AddListingDateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :posted_on, :date, default: Time.now
  end
end
