class ChangeDataTypeOfMapUrl < ActiveRecord::Migration
  def change
  	 change_column :listings, :map_url, :text
  end
end
