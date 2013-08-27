class ChangeDefaultListingPriority < ActiveRecord::Migration
  def change
  	change_column :listings, :priority, :integer, default: 5
  end
end
