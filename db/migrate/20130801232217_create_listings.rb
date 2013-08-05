class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :street_number
      t.boolean :featured_listing, default: false
      t.boolean :show_street_number, default: true
      t.string :unit_number
      t.boolean :show_unit_number, default: true
      t.string :postal_code
      t.string :neighbourhood
      t.integer :lot_frontage
      t.integer :lot_depth
      t.integer :sqft
      t.integer :bedrooms
      t.integer :bathrooms
      t.float :price
      t.float :sold_price
      t.boolean :show_sold_price, default: false
      t.boolean :sold
      t.string :sold_status
      t.float :maintenance_fee
      t.string :virtual_tour_url
      t.string :map_url
      t.string :realtor_url
      t.string :facebook_url
      t.text :description
      t.text :inclusions
      t.text :exclusions
      t.boolean :active, default: true
      t.boolean :draft, default: true
      t.integer :draft_by
      t.references :category

      t.timestamps
    end
  end
end
